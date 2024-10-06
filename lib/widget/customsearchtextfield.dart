import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:iconsax/iconsax.dart';

class CustomSearchTextField extends StatefulWidget {
  final Function(String) onChanged;
  final String hintText;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const CustomSearchTextField({
    Key? key,
    required this.onChanged,
    this.hintText = 'Cari disini..',
    this.focusNode,
    this.controller,
  }) : super(key: key);

  @override
  CustomSearchTextFieldState createState() => CustomSearchTextFieldState();
}

class CustomSearchTextFieldState extends State<CustomSearchTextField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        widget.onChanged(value);

        setState(() {});
      },
      focusNode: widget.focusNode,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Iconsax.search_normal_1, color: primaryColor),
        filled: true,
        fillColor: whiteBackground1Color,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(
                  Iconsax.close_circle,
                  color: primaryColor,
                ),
                onPressed: () {
                  controller.clear();
                  widget.onChanged('');
                  setState(() {});
                },
              )
            : null,
      ),
    );
  }
}
