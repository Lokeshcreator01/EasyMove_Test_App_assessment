import 'package:easymove/core/constants/api_Constsnts.dart';
import 'package:easymove/core/constants/img_constants.dart';
import 'package:easymove/features/login_screen/presentation/cubit/user_cubit.dart';
import 'package:easymove/features/login_screen/presentation/cubit/user_state.dart';
import 'package:easymove/features/login_screen/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideBarScreen extends StatelessWidget {
  const SideBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.75,
      backgroundColor: const Color(0xFFD4E5FF),
      child: SafeArea(
        child: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserLogoutSuccessState) {
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (_) => false,
              );
            }
            if (state is UserErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 12),
              Image.asset(ImgConstants.logo, width: 150, fit: BoxFit.contain),
              const SizedBox(height: 28),
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 26),
              const _SidebarTile(
                icon: Icons.account_circle_outlined,
                title: 'View Profile',
              ),
              const _SidebarTile(
                icon: Icons.card_giftcard_outlined,
                title: 'Loyalty Points',
              ),
              const _SidebarTile(
                icon: Icons.shopping_cart_outlined,
                title: 'My Bookings',
              ),
              const _SidebarTile(
                icon: Icons.info_outline,
                title: 'Help & Support',
              ),
              const _SidebarTile(
                icon: Icons.settings_outlined,
                title: 'Settings',
              ),
              const SizedBox(height: 8),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  final isLoggingOut = state is UserLoadingState;
                  return ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    trailing: isLoggingOut
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.chevron_right),
                    onTap: isLoggingOut
                        ? null
                        : () => context.read<UserCubit>().logout(
                            ApiConstsnts.logout_url,
                          ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  const _SidebarTile({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
