import 'package:easymove/core/constants/app_colors.dart';
import 'package:easymove/core/constants/app_strings.dart';
import 'package:easymove/core/constants/app_styles.dart';
import 'package:easymove/features/login_screen/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class AccountVerifiedPage extends StatelessWidget {
  const AccountVerifiedPage({super.key});

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
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE9E9E9)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  AuthStrings.accountVerified,
                  textAlign: TextAlign.center,
                  style: AppStyles.verifiedTitle,
                ),
                const SizedBox(height: 46),
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (_) => false,
                  ),
                  child: const Text(
                    AuthStrings.goToLogin,
                    style: AppStyles.verifiedLink,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
