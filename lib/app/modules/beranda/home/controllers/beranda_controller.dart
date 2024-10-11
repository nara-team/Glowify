import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/data/models/bannerhome_model.dart';
import 'package:glowify/data/models/featuremain_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      checkIfTutorialSeen();
    });
  }

  void checkIfTutorialSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? tutorialSeen = prefs.getBool('tutorial_seen') ?? false;

    if (!tutorialSeen && targets.isNotEmpty) {
      Future.delayed(const Duration(seconds: 1), () {
        showTutorial(Get.context!);
      });
    }
  }

  Future<void> markTutorialAsSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tutorial_seen', true);
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

    debugPrint(
        "Initializing featureButtonKeys, mainFeatures length: ${mainFeatures.length}");

    featureButtonKeys
        .addAll(List.generate(mainFeatures.length, (index) => GlobalKey()));

    debugPrint(
        "featureButtonKeys initialized with length: ${featureButtonKeys.length}");
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Feature Highlight",
                  style: bold.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const Gap(15),
                const Text(
                  "Di sini Anda dapat menemukan berbagai fitur yang tersedia di aplikasi kami.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: mediumSize,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    for (int i = 0; i < featureButtonKeys.length; i++) {
      if (features.length > i) {
        debugPrint("Adding target for feature: ${features[i]['caption']}");

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
                      style: bold.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const Gap(15),
                    Text(
                      "Ketuk untuk melihat lebih lanjut tentang fitur ${features[i]['caption']}.",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: mediumSize,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        debugPrint(
            "Skipping target for index $i, features length is ${features.length}");
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
        markTutorialAsSeen();
      },
      onSkip: () {
        debugPrint("Tutorial dilewati");
        markTutorialAsSeen();
        return true;
      },
      onClickTarget: (target) {
        debugPrint("Target ditekan: ${target.identify}");
      },
    ).show(context: context);
  }
}
