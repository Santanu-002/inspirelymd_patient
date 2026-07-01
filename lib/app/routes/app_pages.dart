import 'package:get/get.dart';
import 'package:inspirelymd_patient/app/routes/app_routes.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/bindings/dashboard_binding.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:inspirelymd_patient/features/auth/presentation/bindings/auth_binding.dart';
import 'package:inspirelymd_patient/features/auth/presentation/screens/send_otp_screen.dart';
import 'package:inspirelymd_patient/features/auth/presentation/screens/verify_otp_screen.dart';

class AppPages {
  const AppPages._();

  static List<GetPage> get pages => [
        GetPage(
          name: AppRoutes.dashboard,
          page: () => const DashboardScreen(),
          binding: DashboardBinding(),
        ),
        GetPage(
          name: AppRoutes.auth,
          page: () => const SendOtpScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: AppRoutes.verifyOtp,
          page: () => const VerifyOtpScreen(),
          binding: AuthBinding(),
        ),
      ];
}
