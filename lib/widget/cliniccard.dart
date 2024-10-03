import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:glowify/app/theme/sized_theme.dart';

class ClinicCard extends StatelessWidget {
  final String imagePath;
  final String clinicName;
  final String openHours;
  final String address;
  final String distance;
  final VoidCallback onTap;

  const ClinicCard({
    Key? key,
    required this.imagePath,
    required this.clinicName,
    required this.openHours,
    required this.address,
    required this.distance,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          color: whiteBackground1Color,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: abuLightColor,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Image.network(
                imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 100,
                  );
                },
              ),
            ),
            Padding(
              padding: PaddingCustom().paddingHorizontalVertical(16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clinicName,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    openHours,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: abuLightColor,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    address,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: blackColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: PaddingCustom().paddingHorizontalVertical(4, 4),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: whiteBackground1Color,
                            size: 20,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            distance,
                            style: const TextStyle(
                              fontSize: regularSize,
                              color: whiteBackground1Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
