import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/app/routes/app_routes.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/theme/app_theme.dart';
import 'package:inspirelymd_patient/app/bindings/initial_bindings.dart';

class InspirelymdPatientApp extends StatelessWidget {
  const InspirelymdPatientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.common.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialBinding: InitialBindings(),
      initialRoute: AppRoutes.dashboard,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 300),
      getPages: const [],
      home: Scaffold(
        body: Center(
          child: Text('Welcome to InspirelyMD Patient!'),
        ),
      ),
    );
  }
}
