import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
      this.textEditingController,
      this.focusNode,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.cursorColor = AppColors.primaryColor,
      this.inputTextStyle,
      this.textAlignVertical = TextAlignVertical.center,
      this.textAlign = TextAlign.start,
      this.onChanged,
      this.maxLines = 1,
      this.validator,
      this.hintText,
      this.hintStyle,
      this.fillColor = AppColors.fieldFillColor,
      this.prefixIconSrc,
      this.prefixIconColor = AppColors.hintTextColor,
      this.suffixIcon,
      this.suffixIconColor,
      this.fieldBorderRadius = 12,
      this.fieldBorderColor = AppColors.fieldBorderColor,
      this.isPassword = false,
      this.isPrefixIcon = true,
      this.readOnly = false,
      this.onSuffixTap,
      this.autoValidateMode = AutovalidateMode.onUserInteraction,
      super.key
  });

  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color cursorColor;
  final TextStyle? inputTextStyle;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final int? maxLines;
  final void Function(String)? onChanged;
  final FormFieldValidator? validator;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final String? prefixIconSrc;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Widget? suffixIcon;
  final double fieldBorderRadius;
  final Color fieldBorderColor;
  final bool isPassword;
  final bool isPrefixIcon;
  final bool readOnly;
  final VoidCallback? onSuffixTap;
  final AutovalidateMode? autoValidateMode;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      autofocus: false,
      autovalidateMode: widget.autoValidateMode,
      readOnly: widget.readOnly,
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      cursorColor: widget.cursorColor,
      style: widget.inputTextStyle,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      obscureText: widget.isPassword ? obscureText : false,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        fillColor: widget.fillColor,
        filled: true,
        prefixIcon: widget.isPrefixIcon ? Padding(
          padding: const EdgeInsetsDirectional.only(start: 16, top: 20, bottom: 20, end: 12),
          child: SvgPicture.asset(widget.prefixIconSrc ?? ""),
        ) : null,
        prefixIconColor: widget.prefixIconColor,
        suffixIcon: widget.isPassword ? GestureDetector(
            onTap: toggle,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16, top: 20, bottom: 20, end: 12),
              child: SvgPicture.asset(obscureText ? AppIcons.visibleOffIcon : AppIcons.visibleOnIcon),
            )
        ) : GestureDetector(
          onTap: widget.onSuffixTap,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 16, top: 20, bottom: 20, end: 12),
            child: widget.suffixIcon,
          ),
        ),
        suffixIconColor: widget.suffixIconColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
            borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
            gapPadding: 0),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
            borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
            gapPadding: 0),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
            borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
            gapPadding: 0),
      ),
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
