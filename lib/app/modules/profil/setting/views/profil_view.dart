import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/settinglist.dart';
import 'package:iconsax/iconsax.dart';
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
                              Iconsax.user2,
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
    final RxBool isExpanded = false.obs;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: PaddingCustom().paddingOnly(20, 30, 20, 4),
          child: Column(
            children: [
              Column(
                children: [
                  Obx(
                    () => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: primaryColor,
                          backgroundImage: controller.imageUrl.isEmpty
                              ? null
                              : NetworkImage(controller.imageUrl.value),
                          child: controller.imageUrl.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  color: whiteBackground1Color,
                                  size: 35,
                                )
                              : null,
                        ),
                        Positioned(
                          right: -10,
                          bottom: -10,
                          child: Container(
                            decoration: BoxDecoration(
                              color: whiteBackground1Color,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: blackColor.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(Iconsax.gallery_edit5),
                              color: blackColor,
                              onPressed: () => _openEditDialog(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => Text(
                      controller.name.value,
                      style: bold.copyWith(
                        fontSize: 22,
                        color: blackColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Text(
                      controller.email.value,
                      style: medium.copyWith(
                        fontSize: 16,
                        color: abuMedColor,
                      ),
                    ),
                  ),
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
                    const Icon(Iconsax.verify5, color: primaryColor, size: 40),
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
                    Card(
                      shadowColor: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      surfaceTintColor: whiteBackground1Color,
                      // color: whiteBackground1Color,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: abuLightColor, // Warna outline
                          width: 1, // Ketebalan outline
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      child: Column(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: Obx(
                              () => ExpansionTile(
                                trailing: Icon(
                                  isExpanded.value
                                      ? Iconsax.arrow_square_up
                                      : Iconsax.arrow_square_down,
                                ),
                                backgroundColor: Colors.transparent,
                                iconColor: primaryColor,
                                leading: const Icon(Iconsax.clock),
                                title: Text(
                                  'Riwayat',
                                  style: isExpanded.value
                                      ? const TextStyle(color: primaryColor)
                                      : const TextStyle(color: blackColor),
                                ),
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: abuLightColor.withOpacity(0.1),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        SettingList(
                                          icon: Iconsax.calendar_tick,
                                          title: 'Riwayat Booking',
                                          onTap: () {
                                            Get.toNamed('/riwayatbooking');
                                          },
                                        ),
                                        SettingList(
                                          icon: Iconsax.scanning,
                                          title: 'Riwayat Deteksi',
                                          onTap: () {
                                            Get.toNamed('/face-history');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                onExpansionChanged: (bool expanded) {
                                  isExpanded.value = expanded;
                                },
                              ),
                            ),
                          ),
                          SettingList(
                            icon: Iconsax.information,
                            title: 'Informasi Akun',
                            onTap: () {
                              Get.toNamed('/informasiakun');
                            },
                          ),
                          SettingList(
                            icon: Iconsax.message_question,
                            title: 'Pusat Bantuan',
                            onTap: () {
                              Get.toNamed('/pusat-bantuan');
                            },
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Divider(
                      color: blackColor.withOpacity(0.5),
                    ),
                    const Gap(20),
                    Card(
                      shadowColor: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      surfaceTintColor: whiteBackground1Color,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: abuLightColor, // Warna outline
                          width: 1, // Ketebalan outline
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      child: ListTile(
                        leading: const Icon(
                          Iconsax.logout,
                          color: Colors.red,
                        ),
                        title: const Text(
                          'Keluar',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {
                          controller.showLogoutModal();
                        },
                      ),
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
