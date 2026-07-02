import 'package:get/get.dart';
import 'package:inspirelymd_patient/app/routes/app_routes.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/bindings/dashboard_binding.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:inspirelymd_patient/features/auth/presentation/bindings/auth_binding.dart';
import 'package:inspirelymd_patient/features/auth/presentation/screens/send_otp_screen.dart';
import 'package:inspirelymd_patient/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:inspirelymd_patient/features/auth/presentation/screens/splash_screen.dart';
import 'package:inspirelymd_patient/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:inspirelymd_patient/features/notifications/presentation/bindings/notifications_binding.dart';
import 'package:inspirelymd_patient/features/messages/presentation/screens/chat_screen.dart';
import 'package:inspirelymd_patient/features/pharmacy/presentation/bindings/request_refill_binding.dart';
import 'package:inspirelymd_patient/features/pharmacy/presentation/screens/request_refill_screen.dart';
import 'package:inspirelymd_patient/features/messages/presentation/screens/video_call_screen.dart';

class AppPages {
  const AppPages._();

  static List<GetPage> get pages => [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
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
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
      binding: NotificationsBinding(),
    ),
    GetPage(name: AppRoutes.chat, page: () => const ChatScreen()),
    GetPage(
      name: AppRoutes.requestRefill,
      page: () => const RequestRefillScreen(),
      binding: RequestRefillBinding(),
    ),
    GetPage(
      name: AppRoutes.videoCall,
      page: () => const VideoCallScreen(),
    ),
  ];
}
