import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:inspirelymd_patient/core/common/usecase/usecase.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/features/auth/presentation/controllers/auth_controller.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/usecases/get_appointments_usecase.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/usecases/get_prescriptions_usecase.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/usecases/get_vitals_usecase.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/usecases/save_appointment_usecase.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/usecases/save_vitals_usecase.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/book_appointment_sheet.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/widgets/record_vitals_sheet.dart';

class DashboardController extends GetxController {
  final GetAppointmentsUseCase _getAppointmentsUseCase;
  final GetPrescriptionsUseCase _getPrescriptionsUseCase;
  final GetVitalsUseCase _getVitalsUseCase;
  final SaveAppointmentUseCase _saveAppointmentUseCase;
  final SaveVitalsUseCase _saveVitalsUseCase;

  DashboardController(
    this._getAppointmentsUseCase,
    this._getPrescriptionsUseCase,
    this._getVitalsUseCase,
    this._saveAppointmentUseCase,
    this._saveVitalsUseCase,
  );

  final userName = 'Patient'.obs;
  final userEmail = ''.obs;
  final appointments = <Map<String, dynamic>>[].obs;
  final prescriptions = <Map<String, dynamic>>[].obs;
  final vitals = <Map<String, dynamic>>[].obs;

  final isLoading = false.obs;
  final currentNavIndex = 0.obs;

  void changeNavIndex(int index) => currentNavIndex.value = index;

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  void showBookAppointmentSheet() {
    Get.bottomSheet(const BookAppointmentSheet(), isScrollControlled: true);
  }

  void showRecordVitalsSheet() {
    Get.bottomSheet(const RecordVitalsSheet(), isScrollControlled: true);
  }

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    isLoading.value = true;

    // Appointments
    final apptResult = await _getAppointmentsUseCase(NoParams());
    apptResult.fold(
      (failure) => AppSnackbar.destructive(
        'Failed to load appointments: ${failure.message}',
      ),
      (list) => appointments.assignAll(list),
    );

    // Prescriptions
    final prescResult = await _getPrescriptionsUseCase(NoParams());
    prescResult.fold(
      (failure) => AppSnackbar.destructive(
        'Failed to load prescriptions: ${failure.message}',
      ),
      (list) => prescriptions.assignAll(list),
    );

    // Vitals
    final vitalResult = await _getVitalsUseCase(NoParams());
    vitalResult.fold(
      (failure) =>
          AppSnackbar.destructive('Failed to load vitals: ${failure.message}'),
      (list) => vitals.assignAll(list),
    );

    // Load static mock user details for display
    userName.value = 'Sarah Mitchell';
    userEmail.value = 'sarah.mitchell@gmail.com';

    isLoading.value = false;
  }

  Future<void> refreshData() async {
    await loadDashboardData();
  }

  void navigateBack() => Get.back();

  Future<void> signOut() async {
    await Get.find<AuthController>().logout();
  }

  Future<void> bookAppointment({
    required String doctorName,
    required String specialty,
    required DateTime dateTime,
  }) async {
    final appointment = {
      'id': 'appt-${DateTime.now().millisecondsSinceEpoch}',
      'doctorName': doctorName,
      'specialty': specialty,
      'dateTime': dateTime.toIso8601String(),
      'status': 'Upcoming',
      'type': 'In-Person Consultation',
    };

    final result = await _saveAppointmentUseCase(
      SaveAppointmentParams(appointment: appointment),
    );

    result.fold(
      (failure) =>
          AppSnackbar.destructive('Booking failed: ${failure.message}'),
      (_) {
        AppSnackbar.success(AppStrings.dashboard.apptBookedSuccess);
        loadDashboardData();
      },
    );
  }

  Future<void> recordVitals({
    required int heartRate,
    required String bloodPressure,
    required double temperature,
    required double weight,
  }) async {
    final vitalRecord = {
      'id': 'vital-${DateTime.now().millisecondsSinceEpoch}',
      'heartRate': heartRate,
      'bloodPressure': bloodPressure,
      'temperature': temperature,
      'weight': weight,
      'date': DateTime.now().toIso8601String(),
    };

    final result = await _saveVitalsUseCase(
      SaveVitalsParams(vitals: vitalRecord),
    );

    result.fold(
      (failure) =>
          AppSnackbar.destructive('Recording failed: ${failure.message}'),
      (_) {
        AppSnackbar.success(AppStrings.dashboard.vitalsRecordedSuccess);
        loadDashboardData();
      },
    );
  }

  DateTime? _lastPressedAt;

  void handleBackPress() {
    if (currentNavIndex.value != 0) {
      currentNavIndex.value = 0;
    } else {
      final now = DateTime.now();
      if (_lastPressedAt == null ||
          now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
        _lastPressedAt = now;
        AppSnackbar.info('Press back again to exit');
      } else {
        SystemNavigator.pop();
      }
    }
  }
}
