import 'package:flutter/material.dart';
import 'package:glowify/app/theme/app_theme.dart';
import 'package:iconsax/iconsax.dart';

class CustomTextFieldNormal extends StatefulWidget {
  const CustomTextFieldNormal({
    super.key,
    this.fontSize,
    this.controller,
    this.hintText = '',
    this.enabled = true,
    required this.isRequired,
    this.maxLines = 1,
    this.minLines = 1,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.prefix,
    this.errorText,
    this.errorTextWidget,
    this.suffixIcon,
    this.inputColor,
    this.textColor,
    this.isPassword = false,
    this.isHasHint = true,
    this.placeholder,
    this.onChangeText,
    this.onTap,
    this.isHandOver = false,
    this.focusNode,
    this.borderColor,
    this.onEditingComplete,
    this.hintTextStyle,
    this.onChanged,
    this.scrollPadding = const EdgeInsets.all(0),
    this.onFieldSubmitted,
    this.validator,
    this.readOnly = false,
    this.controllerTextStyle,
    this.maxLength,
  });

  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final double? fontSize;
  final String hintText;
  final String? placeholder;
  final bool enabled;
  final bool readOnly;
  final bool isRequired;
  final bool isPassword;
  final bool isHasHint;
  final bool isHandOver;
  final int maxLines;
  final int minLines;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final EdgeInsets scrollPadding;
  final Widget? prefixIcon;
  final Widget? prefix;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? errorTextWidget;
  final Color? inputColor;
  final Color? borderColor;
  final Color? textColor;
  final Function? onChangeText;
  final Function? onTap;
  final Function? onEditingComplete;
  final TextStyle? hintTextStyle;
  final TextStyle? controllerTextStyle;
  final Function(String)? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final int? maxLength;

  @override
  State<CustomTextFieldNormal> createState() => _CustomTextFieldNormalState();
}

class _CustomTextFieldNormalState extends State<CustomTextFieldNormal> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isHasHint && widget.hintText.isNotEmpty)
          Container(
            padding: const EdgeInsets.only(left: 0, top: 12, bottom: 4),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: widget.fontSize ?? 14,
                  color: blackColor,
                ),
                children: [
                  TextSpan(text: widget.hintText, style: widget.hintTextStyle),
                  if (widget.isRequired)
                    const TextSpan(
                      text: '\t*',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
        Card(
          margin: const EdgeInsets.all(0.0),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            readOnly: widget.readOnly,
            scrollPadding: widget.scrollPadding,
            minLines: widget.minLines,
            textInputAction: widget.textInputAction,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onFieldSubmitted,
            controller: widget.controller,
            onChanged: widget.onChanged,
            maxLength: widget.maxLength,
            onTap: () {
              widget.onTap!();
            },
            onEditingComplete: widget.onEditingComplete != null
                ? () {
                    widget.onEditingComplete!();
                  }
                : null,
            enabled: widget.enabled,
            obscureText: widget.isPassword ? _isObscured : false,
            style: widget.controllerTextStyle ??
                TextStyle(
                  fontSize: widget.fontSize ?? 14,
                  fontWeight: FontWeight.w400,
                  color: widget.textColor ??
                      (widget.enabled ? blackColor : Colors.black54),
                ),
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              isDense: true,
              fillColor: widget.inputColor ?? Colors.white,
              filled: true,
              hintText: widget.placeholder ?? 'Masukkan ${widget.hintText}',
              hintStyle: TextStyle(
                fontSize: widget.fontSize ?? 14,
                color: widget.textColor ??
                    (widget.enabled ? Colors.black54 : Colors.black38),
              ),
              prefixIcon: widget.prefixIcon,
              prefix: widget.prefix,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _isObscured ? Iconsax.eye_slash : Iconsax.eye,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                  : widget.suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.black,
                  width: 0.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.black,
                  width: 0.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 0.5,
                ),
              ),
              errorText: widget.errorText,
            ),
            validator: widget.validator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan teks';
                  }
                  return null;
                },
          ),
        ),
      ],
    );
  }
}
