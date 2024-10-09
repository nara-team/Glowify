import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/custom_button.dart';
import 'package:intl/intl.dart';
import '../controllers/buatjanji_controller.dart';

class BuatJanjiView extends GetView<BuatjanjiController> {
  const BuatJanjiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(judul: "${controller.doctor.value.doctorName}"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        controller.doctor.value.profilePicture ?? '',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      controller.doctor.value.doctorName ?? 'Nama Dokter',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Spesialisasi: ${controller.doctor.value.specialization ?? 'Tidak diketahui'}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Pilih Jadwal:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Obx(() {
                return Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: controller.doctor.value.schedule?.map((schedule) {
                        String formattedDate = DateFormat('dd MMM yyyy, HH:mm')
                            .format(schedule.toDate());
                        bool isSelected =
                            controller.selectedSchedule.value == schedule;

                        return GestureDetector(
                          onTap: () {
                            controller.updateSelectedSchedule(schedule);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? Colors.pink[100] : Colors.white,
                              border: Border.all(
                                color: isSelected ? Colors.pink : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                          color: Colors.pink.withOpacity(0.3),
                                          blurRadius: 8)
                                    ]
                                  : [],
                            ),
                            child: Text(
                              formattedDate,
                              style: TextStyle(
                                color: isSelected ? Colors.pink : Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList() ??
                      [],
                );
              }),
              const SizedBox(height: 24),
              const Text(
                'Catatan Tambahan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: TextEditingController(),
                onChanged: (value) {
                  controller.noteController.value = value;
                },
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Catatan tambahan untuk dokter',
                  hintText: 'Tulis catatan di sini...',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: CustomButton(
                  text: 'Buat Janji',
                  onPressed: () {
                    controller.saveBooking();
                  },
                  hasOutline: false,
                  icon: const Icon(
                    Icons.schedule,
                    color: whiteBackground1Color,
                  ),
                  buttonColor: primaryColor,
                  textColor: whiteBackground1Color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
