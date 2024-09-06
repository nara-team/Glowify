import 'dart:io';
import 'package:flutter/material.dart';

class FaceAreaWidget extends StatelessWidget {
  final String title;
  final File? image;
  final Function onTap;

  FaceAreaWidget({required this.title, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Menambahkan teks deskripsi area
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.0, // Membuat teks lebih besar
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onTap(),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: Container(
              height: 180, // Memperbesar tinggi gambar
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 196, 196),
                borderRadius: BorderRadius.circular(16.0),
                image: image != null
                    ? DecorationImage(
                        image: FileImage(image!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: Center(
                child: image == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, color: Colors.white, size: 30.0),
                          SizedBox(width: 8.0),
                          Text(
                            'Ketuk untuk ambil foto',
                            style: TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ],
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
