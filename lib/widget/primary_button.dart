import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trading_app/utiles/extension.dart';
import 'package:trading_app/widget/primary_text.dart';

import '../resource/app_colors.dart';
import '../resource/app_dimension.dart';
import '../resource/app_font.dart';

Widget PrimaryButton({required String btnText,required GestureTapCallback onTap,String leadingIcon = '',bool isLeadingVisible = false}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
       padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(leadingIcon.isNotEmpty)
          SvgPicture.asset(leadingIcon,height: 25,width: 25,color: Colors.white,),
          AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity:!isLeadingVisible ? 1 : 0,
            child: Visibility(
              visible: !isLeadingVisible,
              child: Padding(
                padding:  EdgeInsets.only(left: leadingIcon.isNotEmpty ? 8.0 : 0.0),
                child: PrimaryText(
                  text: btnText,
                  color: AppColors.textColor,
                  weight: AppFont.semiBold,
                  size: AppDimen.textSize16,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget PrimaryButtonLight({required String btnText,required GestureTapCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          border: Border.all(color: AppColors.primaryColor,width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
      child: PrimaryText(
        text: btnText,
        color: AppColors.primaryColor,
        weight: AppFont.bold,
        size: AppDimen.textSize16,
      ),
    ),
  );
}

Widget ButtonWithIcon({required String btnText,required GestureTapCallback onTap,String leadingIcon = "",String trailingIcon = "",String trailingText = "",double? verticalPadding}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          border: Border.all(color: AppColors.secondaryButtonBorderColor,width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
    padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 12,horizontal: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: trailingText.isNotEmpty || leadingIcon.isNotEmpty || trailingIcon.isNotEmpty ?  MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(leadingIcon.isNotEmpty)
            Padding(
                padding: const EdgeInsetsDirectional.only(start: 5),
                child: leadingIcon.toSvgImage()
            ),
          Flexible(
            child: Padding(
              padding: leadingIcon.isNotEmpty || trailingText.isNotEmpty || trailingIcon.isNotEmpty ? const EdgeInsetsDirectional.only(start: 5) : EdgeInsets.zero,
              child: PrimaryText(
                text: btnText,
                color: AppColors.whiteTextColor,
                weight: AppFont.bold,
                size: AppDimen.textSize16,
              ),
            ),
          ),
          if(trailingIcon.isNotEmpty)
            Padding(
                padding: const EdgeInsetsDirectional.only(end: 5),
                child: trailingIcon.toSvgImage()
            ),
          if(trailingText.isNotEmpty)
            Flexible(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 5),
                child: PrimaryText(
                  text: trailingText,
                  color: AppColors.whiteTextColor,
                  weight: AppFont.bold,
                  size: AppDimen.textSize16,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}