import 'package:easymove/features/Services_screen/presentation/pages/services_screen.dart';
import 'package:flutter/material.dart';

class ServiceScreenOnboard extends StatelessWidget {
  const ServiceScreenOnboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetStartedScreen(isOnboarding: true);
  }
}
