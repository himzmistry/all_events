import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

normalTextStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) =>
    TextStyle(
        fontSize: fontSize ?? 15.sp,
        color: color ?? AppColors.black,
        fontWeight: fontWeight ?? FontWeight.normal);

verticalDivider({double? height, Color? color}) => Container(
      height: height ?? 40.0,
      width: 2.0,
      color: color ?? AppColors.black,
    );

horizontalDivider({double? width, Color? color, double? height}) => Container(
      width: width ?? 40.0,
      height: height ?? 1.0,
      color: color ?? AppColors.grey.withOpacity(0.6),
    );

horizontalBox({double? width}) => SizedBox(
      width: width ?? 10.0,
    );

verticalBox({double? height}) => SizedBox(
      height: height ?? 10.0,
    );
