import 'package:inspirelymd_patient/features/pharmacy/data/datasources/i_pharmacy_datasource.dart';
import 'package:inspirelymd_patient/features/pharmacy/data/models/refill_request_model.dart';

class PharmacyDataSource implements IPharmacyDataSource {
  @override
  Future<void> requestRefill(RefillRequestModel model) async {
    await Future.delayed(const Duration(milliseconds: 600));
  }
}
