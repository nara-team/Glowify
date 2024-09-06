import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
  const RiwayatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Booking'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (controller.bookingHistory.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada riwayat booking',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: controller.bookingHistory.length,
              itemBuilder: (context, index) {
                final booking = controller.bookingHistory[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.spa),
                    title: Text(booking['service']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Klinik: ${booking['clinic']}'),
                        Text('Dokter: ${booking['doctor']}'),
                        Text('Tanggal: ${booking['date']}'),
                      ],
                    ),
                    trailing: Text(
                      booking['status']!,
                      style: TextStyle(
                        color: booking['status'] == 'Completed'
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
