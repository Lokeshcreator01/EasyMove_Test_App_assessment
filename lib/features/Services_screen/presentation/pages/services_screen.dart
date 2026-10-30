import 'package:easymove/core/constants/api_Constsnts.dart';
import 'package:easymove/core/constants/app_strings.dart';
import 'package:easymove/core/constants/app_styles.dart';
import 'package:easymove/core/constants/img_constants.dart';
import 'package:easymove/core/widgets/app_bottom_navigation.dart';
import 'package:easymove/features/Services_screen/presentation/cubit/Services_cubit.dart';
import 'package:easymove/features/Services_screen/presentation/cubit/Services_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key, this.showBottomNavigation = true});

  final bool showBottomNavigation;

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
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
          backgroundColor: const Color(0xFFF7F7F7),
          body: SafeArea(
            child: Column(
              children: [
                _ServicesHeader(),
                Expanded(
                  child:
                      state is ServicesLoadingState ||
                          state is ServicesInitState
                      ? const Center(child: CircularProgressIndicator())
                      : state is ServicesErrorState
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              state.message,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : services.isEmpty
                      ? const Center(child: Text('No services available'))
                      : SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(32, 12, 32, 24),
                          child: Column(
                            children: [
                              const Text(
                                'Select Service',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              const SizedBox(height: 18),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: services.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 22,
                                      mainAxisSpacing: 22,
                                      childAspectRatio: 1.05,
                                    ),
                                itemBuilder: (context, index) {
                                  final service = services[index];
                                  return _ServiceTile(
                                    title: service.name,
                                    icon:
                                        _serviceIcons[index %
                                            _serviceIcons.length],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: widget.showBottomNavigation
              ? const AppBottomNavigation(selectedIndex: 1)
              : null,
        );
      },
    );
  }
}

class _ServicesHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
        color: Color(0xFFD2E5FF),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
      ),
      child: Row(
        children: [
          Image.asset(ImgConstants.logo, width: 92, fit: BoxFit.contain),
          const Spacer(),
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Text(
                  ServicesStrings.chooseLocation,
                  style: ServicesStyles.chooseLocation,
                ),
                SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down, size: 15),
              ],
            ),
          ),
          const SizedBox(width: 18),
          const Icon(Icons.notifications_none, size: 22),
          const SizedBox(width: 18),
          const Icon(Icons.menu, size: 23),
        ],
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.title, required this.icon});

  final String title;
  final IconData icon;

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
    );
  }
}
