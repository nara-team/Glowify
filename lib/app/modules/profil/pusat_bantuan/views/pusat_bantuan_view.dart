import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/custom_button.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/pusat_bantuan_controller.dart';

class PusatBantuanView extends GetView<PusatBantuanController> {
  const PusatBantuanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String phoneNumber = "0800123456";
    const String email = "bantuan@glowify.com";
    const String address = "Alamat: Jl. Kebon Jeruk No.12, Jakarta";
    Get.lazyPut<PusatBantuanController>(() => PusatBantuanController());

    return Scaffold(
      appBar: const CustomAppBar(judul: "Pusat Bantuan"),
      body: SingleChildScrollView(
        padding: PaddingCustom().paddingHorizontalVertical(20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hubungi Kami',
              style: semiBold.copyWith(fontSize: largeSize),
            ),
            const Gap(15),
            const Row(
              children: [
                Icon(
                  Iconsax.call,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(phoneNumber)
              ],
            ),
            const Gap(20),
            const Row(
              children: [
                Icon(
                  Iconsax.message_question,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(email)
              ],
            ),
            const Gap(20),
            const Row(
              children: [
                Icon(
                  Iconsax.location,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(address)
              ],
            ),
            const Gap(30),
            Center(
              child: CustomButton(
                text: 'Ajukan Pertanyaan',
                onPressed: () {
                  _showQuestionForm(context);
                },
                icon: const Icon(
                  Iconsax.message,
                  color: whiteBackground1Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuestionForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajukan Pertanyaan'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Pertanyaan',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    );
  }
}
