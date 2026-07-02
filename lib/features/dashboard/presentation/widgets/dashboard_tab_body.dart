import 'package:flutter/material.dart';
import 'package:inspirelymd_patient/features/account/presentation/widgets/account_content.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/dashboard_content.dart';
import 'package:inspirelymd_patient/features/messages/presentation/widgets/messages_content.dart';
import 'package:inspirelymd_patient/features/pharmacy/presentation/widgets/pharmacy_content.dart';
import 'package:inspirelymd_patient/features/programs/presentation/widgets/programs_content.dart';

class DashboardTabBody extends StatelessWidget {
  final int navIndex;

  const DashboardTabBody({super.key, required this.navIndex});

  @override
  Widget build(BuildContext context) {
    return switch (navIndex) {
      0 => const DashboardContent(),
      1 => const ProgramsContent(),
      2 => const MessagesContent(),
      3 => const PharmacyContent(),
      4 => const AccountContent(),
      _ => const DashboardContent(),
    };
  }
}
