import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/beranda/home/views/beranda_view.dart';
import 'package:glowify/app/modules/chat/views/chat_view.dart';
import 'package:glowify/app/modules/profil/setting/views/profil_view.dart';
import 'package:glowify/app/modules/tutorial/views/tutorial_view.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:badges/badges.dart' as badges;
import 'package:iconsax/iconsax.dart';
import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => IndexedStack(
              index: controller.tabIndex.value,
              children: const [
                BerandaView(),
                ChatView(),
                TutorialView(),
                ProfilView(),
              ],
            )),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          unselectedItemColor: abuMedColor,
          selectedItemColor: primaryColor,
          onTap: (index) {
            controller.changeTabIndex(index);
          },
          currentIndex: controller.tabIndex.value,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomNavigationBarItem(
              activeIcon: Iconsax.home_25,
              icon: Iconsax.home_2,
              label: 'Beranda',
            ),
            _bottomNavigationBarItem(
              activeIcon: Iconsax.message5,
              icon: Iconsax.message,
              label: 'Pesan',
            ),
            _bottomNavigationBarItem(
              activeIcon: Iconsax.receipt_2_15,
              icon: Iconsax.receipt_2_14,
              label: 'Tutorial',
            ),
            _bottomNavigationBarItem(
              activeIcon: Iconsax.tag_user5,
              icon: Iconsax.tag_user,
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    required IconData activeIcon,
    required IconData icon,
    required String label,
    int badgeCount = 0,
  }) {
    return BottomNavigationBarItem(
      activeIcon: badgeCount > 0
          ? badges.Badge(
              badgeContent: Text(
                badgeCount.toString(),
                style: const TextStyle(color: whiteBackground1Color),
              ),
              position: badges.BadgePosition.topEnd(top: -10, end: -10),
              child: Icon(activeIcon),
            )
          : Icon(activeIcon),
      icon: badgeCount > 0
          ? badges.Badge(
              badgeContent: Text(
                badgeCount.toString(),
                style: const TextStyle(color: whiteBackground1Color),
              ),
              position: badges.BadgePosition.topEnd(top: -10, end: -10),
              child: Icon(icon),
            )
          : Icon(icon),
      label: label,
    );
  }
}
