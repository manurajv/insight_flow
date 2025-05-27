import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get the current user's chat collection reference
  CollectionReference _getUserChatsCollection() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');
    return _firestore.collection('users').doc(userId).collection('chats');
  }

  // Save a new chat message
  Future<void> saveMessage(String chatId, Message message) async {
    final chatRef = _getUserChatsCollection().doc(chatId);
    
    // Create chat document if it doesn't exist
    if (!(await chatRef.get()).exists) {
      await chatRef.set({
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }

    // Add message to subcollection
    await chatRef.collection('messages').add({
      'text': message.text,
      'isUser': message.isUser,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update chat's updatedAt timestamp
    await chatRef.update({
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Get all messages for a chat
  Stream<List<Message>> getChatMessages(String chatId) {
    return _getUserChatsCollection()
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Message(
          text: data['text'] as String,
          isUser: data['isUser'] as bool,
        );
      }).toList();
    });
  }

  // Get all chats for the current user
  Stream<List<Map<String, dynamic>>> getUserChats() {
    return _getUserChatsCollection()
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'createdAt': data['createdAt'] as Timestamp?,
          'updatedAt': data['updatedAt'] as Timestamp?,
        };
      }).toList();
    });
  }

  // Create a new chat
  Future<String> createNewChat() async {
    final docRef = await _getUserChatsCollection().add({
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  // Delete a chat and all its messages
  Future<void> deleteChat(String chatId) async {
    final chatRef = _getUserChatsCollection().doc(chatId);
    
    // Delete all messages in the chat
    final messages = await chatRef.collection('messages').get();
    for (var doc in messages.docs) {
      await doc.reference.delete();
    }
    
    // Delete the chat document
    await chatRef.delete();
  }
}