import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart'; // Import your app theme
import 'package:glowify/app/theme/sized_theme.dart'; // Import your size theme
import '../controllers/pusat_bantuan_controller.dart';

class PusatBantuanView extends GetView<PusatBantuanController> {
  const PusatBantuanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<PusatBantuanController>(() => PusatBantuanController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Bantuan'),
        centerTitle: true,
        backgroundColor: primaryColor, // Consistent with the theme
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Text(
              'Hubungi Kami',
              style: semiBold.copyWith(fontSize: largeSize), // Using theme
            ),
            const SizedBox(height: 10),
            // Contact Info
            ListTile(
              leading: Icon(Icons.phone, color: primaryColor),
              title: Text(
                'Telepon: 0800-123-456',
                style: medium.copyWith(fontSize: smallSize),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email, color: primaryColor),
              title: Text(
                'Email: bantuan@glowify.com',
                style: medium.copyWith(fontSize: smallSize),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: primaryColor),
              title: Text(
                'Alamat: Jl. Kebon Jeruk No.12, Jakarta',
                style: medium.copyWith(fontSize: smallSize),
              ),
            ),
            const SizedBox(height: 20),
            // Submit Question Button
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.message),
                label: const Text('Ajukan Pertanyaan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // Replaced 'primary' with 'backgroundColor'
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  _showQuestionForm(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show a dialog for submitting a question
  void _showQuestionForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajukan Pertanyaan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
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
                // Handle form submission
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
