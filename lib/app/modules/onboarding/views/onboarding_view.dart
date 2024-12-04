import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
        automaticallyImplyLeading: false, // This will remove the back button
      ),
      body: const Center(
        child: Text('Onboarding Page'),
      ),
    );
  }
}