import 'package:inspirelymd_patient/features/pharmacy/domain/entities/refill_request.dart';

class RefillRequestModel extends RefillRequest {
  const RefillRequestModel({
    required super.medicationName,
    required super.dosageAndPrice,
    super.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'medicationName': medicationName,
      'dosageAndPrice': dosageAndPrice,
      'notes': notes,
    };
  }

  factory RefillRequestModel.fromEntity(RefillRequest entity) {
    return RefillRequestModel(
      medicationName: entity.medicationName,
      dosageAndPrice: entity.dosageAndPrice,
      notes: entity.notes,
    );
  }
}
