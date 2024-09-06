import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/modules/beranda/views/beranda_view.dart';
import 'package:glowify/app/modules/chat/views/chat_view.dart';
import 'package:glowify/app/modules/profil/views/profil_view.dart';
import 'package:glowify/app/modules/riwayat/views/riwayat_view.dart';
import 'package:glowify/app/modules/tutorial/views/tutorial_view.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ionicons/ionicons.dart';
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
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            unselectedItemColor: Colors.grey,
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
                activeIcon: Ionicons.home,
                icon: Ionicons.home_outline,
                label: 'Beranda',
              ),
              _bottomNavigationBarItem(
                activeIcon: Ionicons.chatbox_ellipses,
                icon: Ionicons.chatbox_ellipses_outline,
                label: 'Pesan',
              ),
              _bottomNavigationBarItem(
                activeIcon: Ionicons.newspaper,
                icon: Ionicons.newspaper_outline,
                label: 'Tutorial',
              ),
              _bottomNavigationBarItem(
                activeIcon: Ionicons.person,
                icon: Ionicons.person_outline,
                label: 'Profil',
              ),
            ],
          )),
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
                style: const TextStyle(color: Colors.white),
              ),
              position: badges.BadgePosition.topEnd(top: -10, end: -10),
              child: Icon(activeIcon),
            )
          : Icon(activeIcon),
      icon: badgeCount > 0
          ? badges.Badge(
              badgeContent: Text(
                badgeCount.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              position: badges.BadgePosition.topEnd(top: -10, end: -10),
              child: Icon(icon),
            )
          : Icon(icon),
      label: label,
    );
  }
}
