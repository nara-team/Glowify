import 'dart:io';
import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:iconsax/iconsax.dart';

class FaceAreaWidget extends StatelessWidget {
  final String title;
  final File? image;
  final Function onTap;
  final Function onRemoveImage;

  const FaceAreaWidget({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: bold.copyWith(
              fontSize: largeSize,
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
            child: Stack(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 196, 196),
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
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.image5,
                                  color: whiteBackground1Color, size: 30.0),
                              SizedBox(width: 8.0),
                              Text(
                                'ketuk untuk pilih gambar',
                                style: TextStyle(
                                    color: whiteBackground1Color,
                                    fontSize: 16.0),
                              ),
                            ],
                          )
                        : null,
                  ),
                ),
                if (image != null) 
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: IconButton(
                      icon: const Icon(
                        Iconsax.trash,
                        color: Colors.red,
                      ),
                      onPressed: () => onRemoveImage(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
