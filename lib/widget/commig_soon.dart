import 'package:flutter/material.dart';
import 'package:trading_app/resource/app_colors.dart';
import 'package:trading_app/resource/app_dimension.dart';
import 'package:trading_app/resource/app_font.dart';
import 'package:trading_app/widget/primary_text.dart';

class ComingSoonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PrimaryText(
       text: "Coming Soon",
        size: 18,
        color: AppColors.whiteTextColor,
        weight: AppFont.bold,
      ),
    );
  }
}