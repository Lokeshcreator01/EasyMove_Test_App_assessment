import 'package:easymove/core/constants/api_Constsnts.dart';
import 'package:easymove/core/constants/img_constants.dart';
import 'package:easymove/features/Services_screen/presentation/cubit/Services_cubit.dart';
import 'package:easymove/features/Services_screen/presentation/cubit/Services_state.dart';
import 'package:easymove/features/login_screen/data/storage/auth_storage.dart';
import 'package:easymove/features/login_screen/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceScreenOnboard extends StatefulWidget {
  const ServiceScreenOnboard({super.key});

  @override
  State<ServiceScreenOnboard> createState() => _ServiceScreenOnboardState();
}

class _ServiceScreenOnboardState extends State<ServiceScreenOnboard> {
  @override
  void initState() {
    super.initState();
    context.read<ServicesCubit>().getServices(ApiConstsnts.services_Url);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        final services = state is ServicesSuccessState
            ? state.servicesEntity.services
                  .where((service) => service.deleted == 0)
                  .toList()
            : const [];
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: state is ServicesLoadingState || state is ServicesInitState
                ? const Center(child: CircularProgressIndicator())
                : state is ServicesErrorState
                ? Center(child: Text(state.message))
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Image.asset(
                            ImgConstants.logo,
                            width: 180,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Get started..',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (services.isEmpty)
                          const Text('No services available')
                        else
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: services.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 1.05,
                                ),
                            itemBuilder: (context, index) {
                              final service = services[index];
                              return _OnboardingServiceCard(
                                title: service.name,
                                icon: _icons[index % _icons.length],
                                onTap: index == 0
                                    ? () => _openLogin(context)
                                    : () {},
                              );
                            },
                          ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  static const _icons = [
    Icons.apartment_rounded,
    Icons.directions_car_rounded,
    Icons.hotel_rounded,
    Icons.local_shipping_rounded,
    Icons.public_rounded,
    Icons.engineering_rounded,
    Icons.flight_rounded,
  ];

  Future<void> _openLogin(BuildContext context) async {
    await AuthStorage().markOnboardingSeen();
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }
}

class _OnboardingServiceCard extends StatelessWidget {
  const _OnboardingServiceCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9E9E9)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF00A9E8), Color(0xFFE52D38)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: Icon(icon, size: 44),
              ),
              const SizedBox(height: 9),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.05,
                    color: Color(0xFF444444),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
