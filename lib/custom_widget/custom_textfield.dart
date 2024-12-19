import 'package:all_events/custom_widget/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  var hintTextStyle;
  bool isObsecure;
  bool showBorder;
  var onChanged;
  int maxLines;
  int? maxLength;
  IconData? iconData;
  FocusNode? focusNode;
  TextInputType? inputType;
  bool enable;
  List<TextInputFormatter>? inputFormatters;
  var onIconTapped;

  CustomTextField(
      {super.key,
      required this.controller,
      this.hintText = '',
      this.isObsecure = false,
      this.showBorder = false,
      this.onChanged,
      this.maxLines = 1,
      this.maxLength,
      this.iconData,
      this.inputFormatters,
      this.enable = true,
      this.onIconTapped,
      this.focusNode,
      this.inputType = TextInputType.text,
      this.hintTextStyle});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      focusNode: focusNode ?? FocusNode(),
      obscureText: isObsecure,
      maxLines: maxLines,
      maxLength: maxLength ?? 400,
      controller: controller,
      keyboardType: inputType,
      enabled: enable,
      style: normalTextStyle(fontSize: 13.sp, color: AppColors.primaryColor),
      inputFormatters: inputFormatters ?? [],
      decoration: showBorder
          ? InputDecoration(
              counterText: "",
              hintText: hintText,
              hintStyle: hintTextStyle ?? normalTextStyle(color: AppColors.iconGreyx),
              prefixIcon: iconData != null
                  ? IconButton(
                      onPressed: onIconTapped ?? () {},
                      icon: Icon(
                        iconData,
                        size: 20.0.sp,
                        color: AppColors.grey,
                      ))
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(22.0.r),
                ),
                borderSide: BorderSide(
                  width: 3,
                  color: AppColors.primaryColor,
                ),
              ),
            )
          : InputDecoration(
              counterText: "",
              suffixIcon: iconData != null
                  ? IconButton(
                      onPressed: onIconTapped ?? () {},
                      icon: Icon(iconData, size: 15.0, color: AppColors.grey))
                  : SizedBox(),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: hintTextStyle ?? normalTextStyle(color: AppColors.iconGreyx)),
    );
  }
}
