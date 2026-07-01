import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/scaffold/app_scaffold.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/auth_controller.dart';

class SplashScreen extends GetView<AuthController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      useScrollView: false,
      padding: EdgeInsets.zero,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
