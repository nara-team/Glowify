import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/settinglist.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: PaddingCustom().paddingOnly(20, 30, 20, 4),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.settings,
                    size: 33,
                    color: blackColor,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Obx(() => CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(controller.imageUrl.value),
                      )),
                  const SizedBox(height: 16),
                  Obx(() => Text(
                        controller.name.value,
                        style: bold.copyWith(
                          fontSize: 22,
                          color: blackColor,
                        ),
                      )),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                        controller.email.value,
                        style: medium.copyWith(
                          fontSize: 16,
                          color: abuMedColor,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: PaddingCustom().paddingAll(16),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified, color: primaryColor, size: 40),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pengguna Premium',
                          style: bold.copyWith(
                            fontSize: 18,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          'Sejak Agustus 2024',
                          style: TextStyle(
                            fontSize: 14,
                            color: blackColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                  children: const [
                    SettingList(
                      icon: Icons.history,
                      title: 'Riwayat',
                    ),
                    Divider(),
                    SettingList(
                      icon: Icons.security,
                      title: 'Keamanan',
                    ),
                    Divider(),
                    SettingList(
                      icon: Icons.help_center,
                      title: 'Pusat bantuan',
                    ),
                    Divider(),
                    SettingList(
                      icon: Icons.exit_to_app,
                      title: 'Keluar',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
