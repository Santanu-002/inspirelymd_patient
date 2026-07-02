import 'package:inspirelymd_patient/features/pharmacy/data/models/refill_request_model.dart';

abstract interface class IPharmacyDataSource {
  Future<void> requestRefill(RefillRequestModel model);
}
