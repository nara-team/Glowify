import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/modules/profil/informasi_akun/controllers/informasi_akun_controller.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/custom_button.dart';
import 'package:glowify/widget/custom_textfield.dart';
import 'package:iconsax/iconsax.dart';

class InformasiAkunView extends GetView<InformasiAkunController> {
  const InformasiAkunView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(judul: "Informasi Akun"),
      body: SingleChildScrollView(
        padding: PaddingCustom().paddingHorizontalVertical(16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Obx(
                    () => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: primaryColor,
                          backgroundImage: controller.selectedImageFile.value !=
                                  null
                              ? FileImage(controller.selectedImageFile.value!)
                              : controller.imageUrl.isEmpty
                                  ? null
                                  : NetworkImage(controller.imageUrl.value)
                                      as ImageProvider,
                          child: controller.imageUrl.isEmpty &&
                                  controller.selectedImageFile.value == null
                              ? const Icon(
                                  Icons.person,
                                  color: whiteBackground1Color,
                                  size: 35,
                                )
                              : null,
                        ),
                        Obx(
                          () => controller.isEditing.value
                              ? Positioned(
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
                                      onPressed: () async {
                                        await controller
                                            .showImagePickerBottomSheet(
                                                context);
                                      },
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  const Gap(16),
                  Obx(
                    () => Text(
                      controller.name.value,
                      style: bold.copyWith(
                        fontSize: 22,
                        color: blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24.0),
            const Text(
              'Info Profil',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(8.0),
            Obx(
              () => CustomTextFieldNormal(
                hintText: 'Nama Pengguna',
                placeholder: controller.name.value,
                isRequired: true,
                enabled: controller.isEditing.value,
                controller: controller.nameController,
              ),
            ),
            const Gap(15),
            Obx(
              () => CustomTextFieldNormal(
                hintText: 'Email pengguna',
                placeholder: controller.email.value,
                isRequired: true,
                enabled: controller.isEditing.value,
                controller: controller.emailController,
              ),
            ),
            const Gap(15),
            Obx(
              () => CustomTextFieldNormal(
                hintText: 'Password Lama',
                placeholder: 'Masukkan password lama',
                isRequired: controller.isEditing.value,
                enabled: controller.isEditing.value,
                controller: controller.oldPasswordController,
                isPassword: true,
              ),
            ),
            const Gap(15),
            Obx(
              () => CustomTextFieldNormal(
                hintText: 'Password Baru',
                placeholder: 'Masukkan password baru',
                isRequired: controller.isEditing.value,
                enabled: controller.isEditing.value,
                controller: controller.newPasswordController,
                isPassword: true,
              ),
            ),
            const Gap(25),
            Center(
              child: Obx(
                () => CustomButton(
                  text: controller.isEditing.value
                      ? 'Simpan Perubahan'
                      : 'Edit Informasi',
                  onPressed: () {
                    if (controller.isEditing.value) {
                      controller.updateProfile();
                      if (controller.oldPasswordController.text.isNotEmpty &&
                          controller.newPasswordController.text.isNotEmpty) {
                        controller.changePassword();
                      }
                    }
                    controller.toggleEditingMode();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
