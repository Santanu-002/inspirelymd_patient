import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';

class PharmacyController extends GetxController {
  final recommendationList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _seedRecommendations();
  }

  void _seedRecommendations() {
    recommendationList.assignAll([
      {
        'id': 'tirzepatide',
        'title': 'Tirzepatide',
        'subtitle': 'Upgrade your GLP-1 · from \$449/mo',
        'added': false,
      },
      {
        'id': 'nausea_kit',
        'title': 'Nausea Relief Kit',
        'subtitle': 'Add-on · from \$29/mo',
        'added': false,
      },
      {
        'id': 'longevity_peptides',
        'title': 'Longevity Peptides',
        'subtitle': 'New program · from \$159/mo',
        'added': false,
      },
    ]);
  }

  void toggleRecommendation(int index) {
    final item = recommendationList[index];
    final wasAdded = item['added'] as bool;

    // Toggle added state
    recommendationList[index] = {...item, 'added': !wasAdded};

    if (!wasAdded) {
      AppSnackbar.success(
        '${item['title']} has been added to your care requests.',
      );
    } else {
      AppSnackbar.info('${item['title']} removed from requests.');
    }
  }

  void triggerReorder() {
    AppSnackbar.success('Refill request submitted successfully.');
  }

  void downloadDocument(String docName) {
    AppSnackbar.info('Downloading $docName PDF...');
  }
}
