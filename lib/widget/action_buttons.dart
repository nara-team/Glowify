import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch, // Make buttons stretch to full width
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent, // Use backgroundColor instead of primary
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16), // Larger padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () {
            // Action for "Konsultasi"
          },
          child: Text(
            'Konsultasi Ke Dokter',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        SizedBox(height: 16), // Space between buttons
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Use backgroundColor instead of primary
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.redAccent),
            ),
          ),
          onPressed: () {
            // Action for "Kembali"
            Navigator.pop(context);
          },
          child: Text(
            'Kembali ke Beranda',
            style: TextStyle(color: Colors.redAccent, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
