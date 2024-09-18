import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/settinglist.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({Key? key}) : super(key: key);

  void _openEditDialog(BuildContext context) {
    final nameController = TextEditingController(text: controller.name.value);
    final emailController = TextEditingController(text: controller.email.value);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.pickImageAndEditProfile(
                        nameController.text, emailController.text);
                  },
                  child: Obx(
                    () => CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(controller.imageUrl.value),
                      onBackgroundImageError: (error, stackTrace) {
                        debugPrint('Error loading image: $error');
                      },
                      child: controller.imageUrl.isEmpty
                          ? const Icon(
                              Icons.person,
                              color: whiteBackground1Color,
                              size: 35,
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Change Profile Image',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                controller.updateProfile(
                    newName: nameController.text,
                    newEmail: emailController.text);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
                  onPressed: () => _openEditDialog(context),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(controller.imageUrl.value),
                      child: controller.imageUrl.isEmpty
                          ? const Icon(
                              Icons.person,
                              color: whiteBackground1Color,
                              size: 35,
                            )
                          : null,
                    ),
                  ),
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
                  children: [
                    SettingList(
                      icon: Icons.history,
                      title: 'Riwayat',
                      onTap: () {
                        Get.toNamed('/riwayat');
                      },
                    ),
                    const Divider(),
                    SettingList(
                      icon: Icons.security,
                      title: 'Keamanan',
                      onTap: () {
                        Get.toNamed('/keamanan');
                      },
                    ),
                    const Divider(),
                    SettingList(
                      icon: Icons.help_center,
                      title: 'Pusat Bantuan',
                      onTap: () {
                        Get.toNamed('/pusat-bantuan');
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text('Keluar'),
                      onTap: () {
                        controller.showLogoutModal();
                      },
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
