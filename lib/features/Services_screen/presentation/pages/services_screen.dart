import 'package:easymove/core/constants/api_Constsnts.dart';
import 'package:easymove/core/constants/img_constants.dart';
import 'package:easymove/features/Services_screen/presentation/cubit/Services_cubit.dart';
import 'package:easymove/features/Services_screen/presentation/cubit/Services_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easymove/core/widgets/app_bottom_navigation.dart';
import 'package:easymove/features/homescreen/presentation/pages/home_screen.dart';
import 'package:easymove/features/login_screen/data/storage/auth_storage.dart';
import 'package:easymove/features/login_screen/presentation/pages/login_page.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({
    this.showBottomNavigation = false,
    this.isOnboarding = false,
    super.key,
  });

  final bool showBottomNavigation;
  final bool isOnboarding;

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  // Icons mapped to the cards[cite: 6]
  final List<IconData> _serviceIcons = [
    Icons.apartment_rounded,
    Icons.directions_car_rounded,
    Icons.hotel_rounded,
    Icons.local_shipping_rounded,
    Icons.public_rounded,
    Icons.engineering_rounded,
    Icons.flight_rounded,
  ];

  @override
  void initState() {
    super.initState();
    context.read<ServicesCubit>().getServices(ApiConstsnts.services_Url);
  }

  String _getTitle(List<String> titles, int index, String fallback) {
    if (index < titles.length && titles[index].trim().isNotEmpty) {
      return titles[index];
    }
    return fallback;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        final isLoading =
            state is ServicesLoadingState || state is ServicesInitState;
        final serviceTitles = state is ServicesSuccessState
            ? state.servicesEntity.services
                  .where((service) => service.deleted == 0)
                  .map((service) => service.name)
                  .toList()
            : <String>[];

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. EasyMove Header Logo[cite: 6]
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  ImgConstants.logo,
                                  width: 180,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'click, book, go...',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.blueGrey,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // 2. Title Text[cite: 6]
                        const Text(
                          'Get started..',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Row 1: Real Estate & Car Rental[cite: 6]
                        Row(
                          children: [
                            Expanded(
                              child: ServiceCard(
                                title: _getTitle(
                                  serviceTitles,
                                  0,
                                  'Real Estate',
                                ),
                                icon: _serviceIcons[0],
                                onTap: widget.isOnboarding
                                    ? () => _openLogin(context)
                                    : () => _openHome(context),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ServiceCard(
                                title: _getTitle(
                                  serviceTitles,
                                  1,
                                  'Car Rental\n& Sales',
                                ),
                                icon: _serviceIcons[1],
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Row 2: Short Stays & Packers and Movers[cite: 6]
                        Row(
                          children: [
                            Expanded(
                              child: ServiceCard(
                                title: _getTitle(
                                  serviceTitles,
                                  2,
                                  'Short Stays',
                                ),
                                icon: _serviceIcons[2],
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ServiceCard(
                                title: _getTitle(
                                  serviceTitles,
                                  3,
                                  'Packers &\nMovers',
                                ),
                                icon: _serviceIcons[3],
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Row 3: Travel & Tour & Architecture[cite: 6]
                        Row(
                          children: [
                            Expanded(
                              child: ServiceCard(
                                title: _getTitle(
                                  serviceTitles,
                                  4,
                                  'Travel & Tour',
                                ),
                                icon: _serviceIcons[4],
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ServiceCard(
                                title: _getTitle(
                                  serviceTitles,
                                  5,
                                  'Architecture,\nConstruction &\nInterior Designs',
                                ),
                                icon: _serviceIcons[5],
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Row 4: Single Centered Card for Flights[cite: 6]
                        Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 2,
                              child: ServiceCard(
                                title: _getTitle(serviceTitles, 6, 'Flights'),
                                icon: _serviceIcons[6],
                                onTap: () {},
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
          ),
          bottomNavigationBar: widget.showBottomNavigation
              ? AppBottomNavigation(
                  selectedIndex: 1,
                  onItemSelected: (index) {
                    if (index == 0) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    }
                  },
                )
              : null,
        );
      },
    );
  }

  Future<void> _openLogin(BuildContext context) async {
    await AuthStorage().markOnboardingSeen();
    if (!context.mounted) {
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void _openHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }
}

/// The Single Reusable Card Widget used for all 7 items[cite: 6]
class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24.0),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 12.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gradient Icon[cite: 6]
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF0084FF), Color(0xFFE52D27)],
                    ).createShader(bounds);
                  },
                  child: Icon(icon, size: 42.0),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A4A4A),
                    height: 1.15,
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
