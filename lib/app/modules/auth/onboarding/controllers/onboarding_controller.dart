import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glowify/data/models/onboarding_model.dart';

class OnboardingController extends GetxController {
  var onboardingItems = <OnboardingModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOnboardingItems();
  }

  void fetchOnboardingItems() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final querySnapshot =
          await FirebaseFirestore.instance.collection('onboarding').get();

      final items = querySnapshot.docs.map((doc) {
        return OnboardingModel.fromJson(doc.data());
      }).toList();

      onboardingItems.value = items;
    } catch (e) {
      errorMessage.value = 'Error fetching data: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
