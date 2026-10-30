import 'package:easymove/core/constants/app_colors.dart';
import 'package:easymove/core/constants/api_Constsnts.dart';
import 'package:easymove/core/constants/app_styles.dart';
import 'package:easymove/core/constants/app_strings.dart';
import 'package:easymove/features/login_screen/presentation/pages/forget_password.dart';
import 'package:easymove/features/login_screen/data/storage/auth_storage.dart';
import 'package:easymove/features/homescreen/presentation/pages/home_screen.dart';
import 'package:easymove/features/registration_screen/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({String? hintText, Widget? suffixIcon}) {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFF9E9E9E)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFF9E9E9E)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: App_Colors.PrimaryColor),
      ),
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: AppStyles.input.copyWith(color: Colors.grey),
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, bottom: 4),
      child: Text(text, style: AppStyles.label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (state is UserSuccessState) {
          final token = state.userEntity.token?.trim();
          if (token == null || token.isEmpty) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AuthStrings.invalidLoginCredentials),
                ),
              );
            }
            return;
          }
          await AuthStorage().saveToken(token);
          if (!context.mounted) {
            return;
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        } else if (state is UserErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(33, 68, 33, 24),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 28, 16, 43),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _fieldLabel(AuthStrings.email),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: AppStyles.input,
                      decoration: _inputDecoration(),
                      validator: (value) {
                        final email = value?.trim() ?? '';
                        if (email.isEmpty) return AuthStrings.requiredField;
                        if (!_isValidEmail(email))
                          return AuthStrings.validEmail;
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _fieldLabel(AuthStrings.password),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: AppStyles.input,
                      decoration: _inputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 16,
                          ),
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                      ),
                      validator: _passwordValidator,
                    ),
                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ),
                        ),
                        child: Text(
                          AuthStrings.forgotPassword,
                          style: AppStyles.link.copyWith(
                            color: App_Colors.PrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 21),
                    SizedBox(
                      height: 31,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<UserCubit>().getUser(
                              ApiConstsnts.auth_login,
                              body: {
                                'email': _emailController.text.trim(),
                                'password': _passwordController.text,
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: App_Colors.PrimaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        child: BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) {
                            return state is UserLoadingState
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    AuthStrings.submit,
                                    style: AppStyles.submit,
                                  );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            AuthStrings.doNotHaveAccount,
                            style: AppStyles.account,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupPage(),
                              ),
                            ),
                            child: Text(
                              AuthStrings.createAccountLink,
                              style: AppStyles.link.copyWith(
                                color: App_Colors.PrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  String? _passwordValidator(String? value) {
    if ((value ?? '').isEmpty) return AuthStrings.requiredField;
    if (value!.length < 8) return AuthStrings.validPassword;
    return null;
  }
}
