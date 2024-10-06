import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:glowify/app/modules/beranda/home/views/beranda_view.dart';
import 'package:glowify/app/modules/chat/views/chat_view.dart';
import 'package:glowify/app/modules/profil/setting/views/profil_view.dart';
import 'package:glowify/app/modules/tutorial/views/tutorial_view.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Obx(() => IndexedStack(
              index: controller.tabIndex.value,
              children: const [
                BerandaView(),
                ChatView(),
                Text(""),
                TutorialView(),
                ProfilView(),
              ],
            )),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 2),
          color: whiteBackground1Color,
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            padding: PaddingCustom().paddingHorizontal(1),
            elevation: 0,
            height: 67,
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            notchMargin: 3.0,
            child: Obx(
              () => BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: secondaryColor,
                unselectedItemColor: abuMedColor,
                currentIndex: controller.tabIndex.value,
                onTap: (index) {
                  controller.changeTabIndex(index);
                },
                enableFeedback: false,
                items: [
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      "assets/icons/home_bold.svg",
                      height: 28,
                      colorFilter: const ColorFilter.mode(
                        secondaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      "assets/icons/home_ol.svg",
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        abuMedColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Beranda',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      "assets/icons/messages_bold.svg",
                      height: 28,
                      colorFilter: const ColorFilter.mode(
                        secondaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      "assets/icons/messages_ol.svg",
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        abuMedColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Pesan',
                  ),
                  const BottomNavigationBarItem(
                    icon: SizedBox.shrink(),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      "assets/icons/document_bold.svg",
                      height: 28,
                      colorFilter: const ColorFilter.mode(
                        secondaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      "assets/icons/document_ol.svg",
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        abuMedColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Tutorial',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      "assets/icons/profile_bold.svg",
                      height: 28,
                      colorFilter: const ColorFilter.mode(
                        secondaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      "assets/icons/profile_ol.svg",
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        abuMedColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Profil',
                  ),
                ],
                selectedLabelStyle: const TextStyle(fontSize: 14),
                unselectedLabelStyle: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: CustomFABLocation(offsetY: 20),
      floatingActionButton: SizedBox(
        width: 78,
        height: 78,
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed("/face-detection");
          },
          backgroundColor: Colors.white,
          shape: const CircleBorder(
            side: BorderSide(
              color: whiteBackground1Color,
              width: 4,
            ),
          ),
          elevation: 0,
          highlightElevation: 0,
          hoverColor: primaryColor,
          splashColor: Colors.transparent,
          foregroundColor: Colors.white,
          tooltip: 'Face Detection',
          child: SvgPicture.asset(
            "assets/icons/face-recognition.svg",
            height: 28,
            colorFilter: const ColorFilter.mode(
              abuDarkColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

}

class CustomFABLocation extends FloatingActionButtonLocation {
  final double offsetY;

  CustomFABLocation({this.offsetY = 0});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double posisiX = (scaffoldGeometry.scaffoldSize.width / 2) -
        (scaffoldGeometry.floatingActionButtonSize.width / 2);

    final double posisiY = scaffoldGeometry.contentBottom -
        (scaffoldGeometry.floatingActionButtonSize.height / 2) +
        offsetY;

    return Offset(posisiX, posisiY);
  }
}
