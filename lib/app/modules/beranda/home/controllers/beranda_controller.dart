import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/data/models/bannerhome_model.dart';
import 'package:glowify/data/models/featuremain_model.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class BerandaController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var bannerSliders = <BannerSliderModel>[].obs;
  var mainFeatures = <MainFeatureModel>[].obs;
  var userName = ''.obs;
  var isLoading = true.obs;
  var isbannerLoading = true.obs;

  final GlobalKey featureHighlightKey = GlobalKey();
  final List<GlobalKey> featureButtonKeys = [];
  List<TargetFocus> targets = [];

  @override
  void onInit() {
    super.onInit();
    fetchUserName();
    fetchBannerSliders();
    fetchMainFeatures();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (targets.isNotEmpty) {
        showTutorial(Get.context!);
      }
    });
  }

  void fetchBannerSliders() async {
    isbannerLoading.value = true;
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('bannerslider').get();
      var banners = snapshot.docs
          .map((doc) => BannerSliderModel.fromJson(doc.data()))
          .toList();
      bannerSliders.assignAll(banners);
    } catch (e) {
      debugPrint("Error fetching banner slider data: ${e.toString()}");
    } finally {
      isbannerLoading.value = false;
    }
  }

  void fetchUserName() async {
    try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userName.value = userDoc['fullName'] ?? 'No Name';
    } catch (e) {
      debugPrint("Gagal mendapatkan userdata: ${e.toString()}");
    }
  }

  void fetchMainFeatures() async {
    try {
      isLoading(true);

      var snapshot =
          await FirebaseFirestore.instance.collection('mainfeature').get();
      var features = snapshot.docs
          .map((doc) => MainFeatureModel.fromJson(doc.data()))
          .toList()
          .reversed
          .toList();

      mainFeatures.assignAll(features);
      initializeFeatureKeys();
      initTargets(features
          .map((feature) => {
                "caption": feature.title,
                "route": feature.route,
              })
          .toList());
      isLoading(false);

      Future.delayed(const Duration(milliseconds: 500), () {
        if (targets.isNotEmpty && Navigator.of(Get.context!).overlay != null) {
          showTutorial(Navigator.of(Get.context!).overlay!.context);
        }
      });
    } catch (e) {
      isLoading(false);
      debugPrint("Error fetching data: ${e.toString()}");
    }
  }

  void initializeFeatureKeys() {
    featureButtonKeys.clear();
    featureButtonKeys
        .addAll(List.generate(mainFeatures.length, (index) => GlobalKey()));
  }

  void initTargets(List<Map<String, dynamic>> features) {
    targets.clear();

    targets.add(
      TargetFocus(
        identify: "Feature",
        keyTarget: featureHighlightKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Feature Highlight",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Di sini Anda dapat menemukan berbagai fitur yang tersedia di aplikasi kami.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    for (int i = featureButtonKeys.length - 1; i >= 0; i--) {
      if (features.length > i) {
        targets.add(
          TargetFocus(
            identify: "FeatureButton_$i",
            keyTarget: featureButtonKeys[i],
            contents: [
              TargetContent(
                align: ContentAlign.bottom,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fitur ${features[i]['caption']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Ketuk untuk melihat lebih lanjut tentang fitur ${features[i]['caption']}.",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  void showTutorial(BuildContext context) {
    TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black.withOpacity(0.7),
      textSkip: "Lewati",
      onFinish: () {
        debugPrint("Tutorial selesai");
      },
      onSkip: () {
        debugPrint("Tutorial dilewati");
        return true;
      },
      onClickTarget: (target) {
        debugPrint("Target ditekan: ${target.identify}");
      },
    ).show(context: context);
  }
}
