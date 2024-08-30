import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tutorial_controller.dart';

class TutorialView extends GetView<TutorialController> {
  const TutorialView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Comming soon',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
