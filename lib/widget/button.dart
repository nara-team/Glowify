import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:glowify/app/theme/app_theme.dart';

class BtnLogin extends StatelessWidget {
  final String btnText;
  final VoidCallback? onPressed;
  final RxBool isLoading;

  const BtnLogin({
    super.key,
    required this.btnText,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: SizedBox(
            height: 45,
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, 50),
                ),
                backgroundColor: MaterialStateProperty.all(
                  primaryColor,
                ),
              ),
              onPressed: isLoading.value ? null : onPressed,
              child: isLoading.value
                  ? const CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      btnText,
                      style: medium.copyWith(
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ));
  }
}
