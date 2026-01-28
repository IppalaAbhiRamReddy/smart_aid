import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';
import '../../services/auth_service.dart';
import '../../services/localization_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final loc = Provider.of<LocalizationService>(context, listen: false);

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(loc.translate('fill_all_fields'))));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.signInWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) {
        setState(() => _isLoading = false);
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        final errorMessage = loc.translate(e.toString());
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(loc.translate('error')),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(loc.translate('ok')),
              ),
            ],
          ),
        );
      }
    }
  }

  void _showForgotPasswordDialog() {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    final TextEditingController resetEmailController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(loc.translate('reset_password')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(loc.translate('reset_password_desc')),
            const SizedBox(height: 16),
            TextField(
              controller: resetEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: loc.translate('email'),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(loc.translate('cancel')),
          ),
          ElevatedButton(
            onPressed: () async {
              if (resetEmailController.text.isNotEmpty) {
                Navigator.pop(dialogContext);
                try {
                  await _authService.sendPasswordResetEmail(
                    resetEmailController.text.trim(),
                  );
                  if (mounted) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(loc.translate('email_sent')),
                        content: Text(
                          '${loc.translate('password_reset_sent')} ${resetEmailController.text.trim()}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: Text(loc.translate('ok')),
                          ),
                        ],
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    // Try to translate the error message (it might be a key)
                    final errorMessage = loc.translate(e.toString());
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(loc.translate('error')),
                        content: Text(errorMessage), // Display translated error
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: Text(loc.translate('ok')),
                          ),
                        ],
                      ),
                    );
                  }
                }
              }
            },
            child: Text(loc.translate('send')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: AppStyles.logoContainerDecoration,
                  child: const Icon(
                    Icons.security,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  loc.translate('app_title'),
                  style: AppTextStyles.heading.copyWith(fontSize: 28),
                ),
                const SizedBox(height: 8),
                Text(
                  loc.translate('welcome_back'),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subHeading,
                ),
                const SizedBox(height: 48),

                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: AppStyles.cardDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.translate('email'),
                        style: AppTextStyles.inputLabel,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: AppTextStyles.inputText,
                        decoration: AppStyles.inputDecoration(
                          hintText: loc.translate('enter_email'),
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        loc.translate('password'),
                        style: AppTextStyles.inputLabel,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        style: AppTextStyles.inputText,
                        decoration: AppStyles.inputDecoration(
                          hintText: loc.translate('enter_password'),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _showForgotPasswordDialog,
                          child: Text(
                            loc.translate('forgot_password'),
                            style: const TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(loc.translate('login')),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loc.translate('new_user'),
                      style: AppTextStyles.subHeading,
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        context.go('/signup');
                      },
                      child: Text(
                        loc.translate('signup'),
                        style: AppTextStyles.buttonText.copyWith(
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
