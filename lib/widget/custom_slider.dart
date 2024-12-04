import 'package:flutter/material.dart';
import 'package:trading_app/widget/primary_text.dart';

import '../resource/app_colors.dart';
import '../resource/app_dimension.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.yellowColor,
            activeTickMarkColor: AppColors.yellowColor,
            overlappingShapeStrokeColor: AppColors.yellowColor,
            valueIndicatorStrokeColor: AppColors.yellowColor,
            valueIndicatorColor: AppColors.yellowColor,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: AppColors.yellowColor,
            overlayColor: Colors.blue.withOpacity(0.2),
            tickMarkShape: const RoundSliderTickMarkShape(),
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            valueIndicatorTextStyle: const TextStyle(color: AppColors.textColor),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
          ),
          child: Slider(
            value: _sliderValue,
            min: 0,
            max: 100,
            divisions: 4,
            label: "${_sliderValue.toInt()}%", // Display percentage
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding:const EdgeInsetsDirectional.only(start: 20),
                child: PrimaryText(text: "0%",color: AppColors.whiteTextColor,size: AppDimen.textSize12,)),
            PrimaryText(text: "25%",color: AppColors.whiteTextColor,size: AppDimen.textSize12,),
            PrimaryText(text: "50%",color: AppColors.whiteTextColor,size: AppDimen.textSize12,),
            PrimaryText(text: "75%",color: AppColors.whiteTextColor,size: AppDimen.textSize12,),
            PrimaryText(text: "100%",color: AppColors.whiteTextColor,size: AppDimen.textSize12,),
          ],
        ),
      ],
    );
  }
}