import 'package:flutter/material.dart';
import 'package:inspirelymd_patient/app/inspirelymd_patient_app.dart';
import 'package:inspirelymd_patient/app_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.initialize();

  runApp(const InspirelymdPatientApp());
}
