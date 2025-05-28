const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');
const { Pool } = require('pg');  // Add PostgreSQL
const dotenv = require('dotenv');

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

// Store active connections
const connections = new Map();

// Connect to database
app.post('/api/connect', async (req, res) => {
  try {
    const { type, host, port, database, username, password } = req.body;
    
    let connection;
    if (type === 'mysql') {
      connection = await mysql.createConnection({
        host,
        port,
        database,
        user: username,
        password,
      });
    } else if (type === 'postgres') {
      connection = new Pool({
        host,
        port,
        database,
        user: username,
        password,
        ssl: req.body.useSSL ? { rejectUnauthorized: false } : false,
      });
      // Test the connection
      await connection.query('SELECT NOW()');
    } else {
      throw new Error('Unsupported database type');
    }

    // Generate a simple token (in production, use proper JWT)
    const token = Math.random().toString(36).substring(7);
    connections.set(token, { type, connection });

    res.json({ token });
  } catch (error) {
    console.error('Connection error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Test connection
app.get('/api/test-connection', async (req, res) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token || !connections.has(token)) {
    return res.status(401).json({ error: 'Not connected' });
  }

  try {
    const { type, connection } = connections.get(token);
    if (type === 'mysql') {
      await connection.query('SELECT 1');
    } else if (type === 'postgres') {
      await connection.query('SELECT NOW()');
    }
    res.json({ status: 'connected' });
  } catch (error) {
    console.error('Test connection error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Execute query
app.post('/api/query', async (req, res) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token || !connections.has(token)) {
    return res.status(401).json({ error: 'Not connected' });
  }

  try {
    const { sql } = req.body;
    const { type, connection } = connections.get(token);
    
    let results;
    if (type === 'mysql') {
      [results] = await connection.query(sql);
    } else if (type === 'postgres') {
      results = await connection.query(sql);
      results = results.rows;  // PostgreSQL returns results in rows property
    }
    
    res.json({ results });
  } catch (error) {
    console.error('Query error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Disconnect
app.post('/api/disconnect', async (req, res) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (token && connections.has(token)) {
    try {
      const { type, connection } = connections.get(token);
      if (type === 'mysql') {
        await connection.end();
      } else if (type === 'postgres') {
        await connection.end();
      }
      connections.delete(token);
    } catch (error) {
      console.error('Disconnect error:', error);
    }
  }
  res.json({ status: 'disconnected' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
}); 