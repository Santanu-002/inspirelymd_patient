import 'package:get/get.dart';
import 'package:inspirelymd_patient/app/routes/app_routes.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/bindings/dashboard_binding.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/screens/dashboard_screen.dart';

class AppPages {
  const AppPages._();

  static List<GetPage> get pages => [
        GetPage(
          name: AppRoutes.dashboard,
          page: () => const DashboardScreen(),
          binding: DashboardBinding(),
        ),
      ];
}
