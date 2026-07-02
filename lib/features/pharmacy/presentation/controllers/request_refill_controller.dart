import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/features/pharmacy/domain/entities/refill_request.dart';
import 'package:inspirelymd_patient/features/pharmacy/domain/usecases/request_refill_usecase.dart';

class RequestRefillController extends GetxController {
  final RequestRefillUseCase _requestRefillUseCase;

  RequestRefillController(this._requestRefillUseCase);

  final isLoading = false.obs;

  Future<void> confirmRefill() async {
    isLoading.value = true;
    final request = RefillRequest(
      medicationName: AppStrings.pharmacy.semaglutideMedication,
      dosageAndPrice: AppStrings.pharmacy.semaglutideDosageAndPrice,
    );

    final result = await _requestRefillUseCase(request);
    isLoading.value = false;

    result.fold(
      (failure) => AppSnackbar.destructive(failure.message),
      (_) {
        AppSnackbar.success(AppStrings.pharmacy.refillRequestSuccess);
        Get.back();
      },
    );
  }

  void navigateBack() {
    Get.back();
  }
}
