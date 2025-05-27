import 'package:flutter/material.dart';
import 'package:insight_flow/features/auth/screens/register_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/glassmorphism_effects.dart';
import '../../../core/widgets/buttons/glass_button.dart';
import '../../../core/widgets/inputs/glass_input_field.dart';
import '../../../core/widgets/other/app_logo.dart';
import '../../../core/widgets/other/loading_indicator.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await context.read<AuthService>().signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.5,
                colors: [
                  AppColors.primary.withOpacity(0.2),
                  AppColors.background,
                ],
              ),
            ),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: GlassContainer(
                width: MediaQuery.of(context).size.width * 0.9,
                //maxWidth: 500,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const AppLogo(size: 80),
                        const SizedBox(height: 24),
                        Text(
                          AppStrings.loginTitle,
                          style: GlassTextStyle.headline,
                        ),
                        const SizedBox(height: 32),
                        GlassInputField(
                          controller: _emailController,
                          labelText: AppStrings.emailLabel,
                          icon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.emailRequired;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        GlassInputField(
                          controller: _passwordController,
                          labelText: AppStrings.passwordLabel,
                          icon: Icons.lock,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.passwordRequired;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        GlassButton(
                          text: AppStrings.loginButton,
                          onPressed: _isLoading ? null : () => _submit(),
                          width: double.infinity,
                          isActive: true,
                        ),

                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            AppStrings.registerPrompt,
                            style: GlassTextStyle.body.copyWith(
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading) const LoadingIndicator(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}