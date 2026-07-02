class RefillRequest {
  final String medicationName;
  final String dosageAndPrice;
  final String? notes;

  const RefillRequest({
    required this.medicationName,
    required this.dosageAndPrice,
    this.notes,
  });
}
