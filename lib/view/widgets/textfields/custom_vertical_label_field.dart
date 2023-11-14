import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/utils/app_colors.dart';

class CustomVerticalLabelField extends StatefulWidget {

  const CustomVerticalLabelField({
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
    this.fillColor = AppColors.transparentColor,
    this.fieldBorderRadius = 12,
    this.fieldBorderColor = AppColors.underlineFieldBorderColor,
    this.isPassword = false,
    required this.label,
    required this.textController,
    this.readOnly = true,

    super.key
  });

  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color cursorColor;
  final TextStyle? inputTextStyle;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final int? maxLines;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final double fieldBorderRadius;
  final Color fieldBorderColor;
  final bool isPassword;
  final String label;
  final TextEditingController textController;
  final bool readOnly;

  @override
  State<CustomVerticalLabelField> createState() => _CustomVerticalLabelFieldState();
}

class _CustomVerticalLabelFieldState extends State<CustomVerticalLabelField> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.publicSans(
            fontWeight: FontWeight.w600,
            color: AppColors.colorBlack,
            fontSize: 16
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          readOnly: widget.readOnly,
          controller: widget.textController,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          cursorColor: widget.cursorColor,
          style: widget.inputTextStyle,
          onChanged: widget.onChanged,
          maxLines: widget.maxLines,
          obscureText: widget.isPassword ? obscureText : false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            fillColor: widget.fillColor,
            filled: true,
            contentPadding: const EdgeInsetsDirectional.only(bottom: 12),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.fieldBorderColor, width: 1),
            ),
          ),
        )
      ],
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
