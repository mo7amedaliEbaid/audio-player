import 'package:flutter/material.dart';

import '../configs/app_dimensions.dart';
import '../configs/app_theme.dart';
import '../configs/app_typography.dart';
import '../configs/space.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final bool? enabled;
  final FocusNode? node;
  final String? hint;
  final double? width;
  final bool? isPass;
  final Widget? prefixIcon;
  final String? initialValue;

  final FormFieldValidator? validatorFtn;
  final Function? onEditComplete;
  final Function(String)? onFieldSubmit;
  final String? errorText;
  final String Function(String?)? onChangeFtn;

  const CustomTextField({
    Key? key,
    this.enabled,
    this.initialValue,
    this.validatorFtn,
    this.onEditComplete,
    this.onChangeFtn,
    this.onFieldSubmit,
    this.errorText,
    this.prefixIcon,
    this.isPass = false,
    this.width = double.infinity,
    this.textInputAction = TextInputAction.done,
    this.node,
    required this.controller,
    required this.hint,
    required this.textInputType,
  }) : super(key: key);

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool showPass = true;
  _showPass() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.normalize(250),
      child: TextFormField(
        enabled: widget.enabled ?? true,
        initialValue: widget.initialValue,
        controller: widget.controller,
        autofocus: false,
        obscureText: widget.isPass! ? showPass : false,
        textInputAction: widget.textInputAction,
        keyboardType: widget.textInputType,
        focusNode: widget.node,
        decoration: InputDecoration(
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPass!
              ? TextButton(
                  onPressed: _showPass,
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(AppTheme.c!.primary),
                  ),
                  child: Text(
                    showPass ? 'Show' : 'Hide',
                  ),
                )
              : null,
          filled: true,
          contentPadding: Space.all(1, 0.9),
          hintText: widget.hint,
          hintStyle: AppText.b2!.copyWith(
            color: AppTheme.c!.textSub,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(360),
            borderSide: BorderSide(
              width: AppDimensions.normalize(0.75),
              color: AppTheme.c!.textSub!.withAlpha(100),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(360),
            borderSide: BorderSide(
              color: AppTheme.c!.primary!,
              width: AppDimensions.normalize(0.75),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(360),
            borderSide: BorderSide(
              color: Colors.red.withAlpha(200),
              width: AppDimensions.normalize(0.75),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(360),
            borderSide: BorderSide(
              color: Colors.red.withAlpha(200),
              width: AppDimensions.normalize(0.75),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(360),
            borderSide: BorderSide(
              width: AppDimensions.normalize(0.75),
              color: AppTheme.c!.textSub!.withAlpha(100),
            ),
          ),
        ),
        validator: widget.validatorFtn,
        onChanged: widget.onChangeFtn,
      ),
    );
  }
}
