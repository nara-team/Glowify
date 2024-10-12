import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';
import 'package:glowify/widget/appbarcustom.dart';
import 'package:glowify/widget/custom_button.dart';
import 'package:glowify/widget/custom_textfield.dart';
import 'package:glowify/widget/showdialog_custom.dart';
import 'package:glowify/widget/snackbar_custom.dart';
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
          padding: PaddingCustom().paddingHorizontalVertical(20, 10),
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
                    const Gap(16),
                    Text(
                      controller.doctor.value.doctorName ?? 'Nama Dokter',
                      style: bold.copyWith(
                        fontSize: 22,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      'Spesialisasi: ${controller.doctor.value.specialization ?? 'Tidak diketahui'}',
                      style: const TextStyle(
                        fontSize: regularSize,
                        color: abuDarkColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(24),
              Text(
                'Pilih Jadwal:',
                style: semiBold.copyWith(
                  fontSize: largeSize,
                ),
              ),
              const Gap(8),
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
                            if (isSelected) {
                              controller.selectedSchedule.value = null;
                            } else {
                              controller.updateSelectedSchedule(schedule);
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: PaddingCustom().paddingHorizontalVertical(
                              20,
                              10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              border: Border.all(
                                color: isSelected ? primaryColor : abuMedColor,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              formattedDate,
                              style: TextStyle(
                                color: isSelected
                                    ? whiteBackground1Color
                                    : blackColor,
                              ),
                            ),
                          ),
                        );
                      }).toList() ??
                      [],
                );
              }),
              const Gap(24),
              Text(
                'Catatan Tambahan',
                style: semiBold.copyWith(
                  fontSize: largeSize,
                ),
              ),
              const Gap(8),
              CustomTextFieldNormal(
                controller: TextEditingController(),
                placeholder: 'Masukkan catatan tambahan untuk dokter',
                isHasHint: false,
                isRequired: false,
                maxLines: 4,
                minLines: 1,
                onChanged: (value) {
                  controller.noteController.value = value;
                },
                enabled: true,
                controllerTextStyle: const TextStyle(
                  fontSize: regularSize,
                  color: blackColor,
                ),
              ),
              const Gap(20),
              Obx(() {
                bool isScheduleSelected =
                    controller.selectedSchedule.value != null;

                return Center(
                  child: CustomButton(
                    text: 'Buat Janji',
                    onPressed: () {
                      if (isScheduleSelected) {
                        ConfirmationDialog.show(
                          textKonfirmasi: "Lanjut Booking",
                          title: 'Konfirmasi',
                          content:
                              'Apakah Anda yakin ingin melanjutkan booking?',
                          onConfirm: () async{
                            await controller.saveBooking();
                          },
                        );
                      } else {
                        const SnackBarCustom(
                          judul: 'Maaf',
                          pesan: 'Silakan pilih jadwal terlebih dahulu',
                          isHasIcon: true,
                          iconType: SnackBarIconType.warning,
                        ).show();
                      }
                    },
                    icon: const Icon(
                      Icons.schedule,
                      color: whiteBackground1Color,
                    ),
                    buttonColor:
                        isScheduleSelected ? primaryColor : abuLightColor,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
