import 'package:easymove/core/constants/app_colors.dart';
import 'package:easymove/core/constants/app_styles.dart';
import 'package:easymove/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFF777777)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFF777777)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: App_Colors.PrimaryColor),
      ),
    );
  }

  void _confirmEmail() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${AuthStrings.passwordResetSent}${_emailController.text.trim()}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 19),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(AuthStrings.signIn, style: AppStyles.appBarTitle),
        titleSpacing: 0,
        backgroundColor: App_Colors.AppBarColor,
        foregroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30, 81, 30, 24),
          child: Container(
            padding: const EdgeInsets.fromLTRB(21, 33, 21, 48),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE9E9E9)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    AuthStrings.forgotYourPassword,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 27),
                  const Text(
                    AuthStrings.resetPasswordMessage,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color: Color(0xFF252525),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Padding(
                    padding: EdgeInsets.only(left: 18, bottom: 5),
                    child: Text(
                      AuthStrings.enterEmailAccount,
                      style: AppStyles.label,
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: AppStyles.input,
                    decoration: _inputDecoration(),
                    validator: (value) {
                      final email = value?.trim() ?? '';
                      if (email.isEmpty || !email.contains('@')) {
                        return AuthStrings.validEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 29),
                  SizedBox(
                    height: 39,
                    child: ElevatedButton(
                      onPressed: _confirmEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: App_Colors.PrimaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        AuthStrings.confirmMail,
                        style: AppStyles.submit,
                      ),
                    ),
                  ),
                  const SizedBox(height: 31),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: Text(
                        AuthStrings.backToLogin,
                        style: AppStyles.link.copyWith(
                          color: App_Colors.PrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
