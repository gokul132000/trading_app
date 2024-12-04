import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_app/features/home_main/prensentation/bloc/trade_view_bloc/trade_view_bloc.dart';
import 'package:trading_app/features/home_main/prensentation/bloc/trade_view_bloc/trade_view_event.dart';
import 'package:trading_app/features/home_main/prensentation/bloc/trade_view_bloc/trade_view_state.dart';
import 'package:trading_app/resource/app_dimension.dart';
import 'package:trading_app/resource/app_font.dart';
import 'package:trading_app/utiles/extension.dart';
import 'package:trading_app/widget/primary_button.dart';
import 'package:trading_app/widget/primary_scaffold.dart';
import 'package:trading_app/widget/primary_text.dart';
import '../../../../resource/app_colors.dart';
import '../../../../resource/app_images.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../../widget/carner_button.dart';
import '../../../../widget/custom_slider.dart';
import '../../../../widget/custom_tab_bar.dart';
import 'chart_web_view_page.dart';

class TradeViewPage extends StatefulWidget {
  const TradeViewPage({super.key});

  @override
  State<TradeViewPage> createState() => _TradeViewPageState();
}

class _TradeViewPageState extends State<TradeViewPage>
    with TickerProviderStateMixin {
  Widget get _paddingHeight => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TradeViewBloc()..add(const TradeViewEventInit()),
      child:
          BlocBuilder<TradeViewBloc, TradeViewState>(builder: (context, state) {
        return BlocListener<TradeViewBloc, TradeViewState>(
          listener: (context, state) {
            if (state is TradeViewStateStarted) {}
          },
          child: PrimaryScaffold(
            body: _showBodyContent(context, state),
          ),
        );
      }),
    );
  }

  Widget _showBodyContent(context, state) {
    if (state is TradeViewStateLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is TradeViewStateNoDataFound) {
      return _noDataFoundView(context);
    } else {
      return _tradeView(context);
    }
  }

  _noDataFoundView(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: PrimaryText(text: "No Data found."),
      ),
    );
  }

  _tradeView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerView(),
          _headerAmountPercentageView(),
          _bodyContentView(context),
        ],
      ),
    );
  }

  Widget _headerView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _headerLeftSection(),
        _headerRightSection(),
      ],
    );
  }

  Widget _headerLeftSection() {
    return Row(
      children: [
        _headerLeftArrowButton(),
        const SizedBox(width: 8),
        PrimaryButtonLight(
          btnText: "10x",
          onTap: () {},
        ),
      ],
    );
  }

  _headerLeftArrowButton() {
    return Row(
      children: [
        PrimaryText(
          text: 'BTC/USDT',
          size: AppDimen.textSize16,
          weight: AppFont.bold,
          color: AppColors.whiteTextColor,
        ),
        const SizedBox(
          width: 12,
        ),
        AppImages.downArrowImageSvg.toSvgImage(height: 10.0, width: 10.0),
        const SizedBox(
          width: 12,
        ),
      ],
    );
  }

  Widget _headerRightSection() {
    return Row(
      children: [
        AppImages.filterImageSvg.toSvgImage(),
        const SizedBox(width: 20),
        AppImages.moreHorizontalImageSvg.toSvgImage(),
      ],
    );
  }

  _headerAmountPercentageView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: PrimaryText(
        text: "-3.95%",
        weight: AppFont.medium,
        size: AppDimen.textSize14,
        color: AppColors.redTextColor,
      ),
    );
  }

  _bodyContentView(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bodyLeftContentView(),
                _bodyRightContentView(context),
              ],
            ),
            CustomTabBar(),
          ],
        ),
      ),
    );
  }



  _bodyLeftContentView() {
    return Expanded(
      child: Column(
        children: [
          _borrowView(),
          _paddingHeight,
          _buySellView(),
          _limitedOrderView(),
          _quantityView(),
          const CustomSlider(),
          _paddingHeight,
          _totalView(),
          _buyBTCView(),
          _paddingHeight,
        ],
      ),
    );
  }

  _bodyRightContentView(BuildContext context) {
    return StreamBuilder<Map>(
        stream: context.read<TradeViewBloc>().orderBookDataController.stream,
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsetsDirectional.only(start: 20.0),
            child: IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tableViewContent(false, snapshot.data ?? {}),
                  if (snapshot.data?.isNotEmpty ?? false) ...[
                    _paddingHeight,
                    _tableTotalView(),
                    _paddingHeight,
                  ],
                  _tableViewContent(true, snapshot.data ?? {}),
                  _paddingHeight,
                  if (snapshot.data?.isNotEmpty ?? false)
                    _tabBleViewFilterContent(),
                ],
              ),
            ),
          );
        });
  }

  _tabBleViewFilterContent(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: AppImages.tableImageSvg
              .toSvgImage(height: 20, width: 20),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 5,
          child: ButtonWithIcon(
            btnText: '0.01',
            verticalPadding: 3,
            trailingIcon: AppImages.downArrowImageSvg,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  _tableViewContent(bool isFromPositive, Map mapData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tablePriceView(isFromPositive, mapData),
        const SizedBox(
          width: 16,
        ),
        _tableQuantityView(isFromPositive, mapData),
      ],
    );
  }

  _borrowView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: ButtonWithIcon(
              btnText: 'Auto-Borrow',
              trailingIcon: AppImages.downArrowImageSvg,
              onTap: () {}),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
            child: ButtonWithIcon(
                btnText: '10x',
                trailingIcon: AppImages.downArrowImageSvg,
                onTap: () {})),
      ],
    );
  }

  _buySellView() {
    return Row(
      children: [
        Expanded(
          child: CustomShapeButton(
            text: "Buy",
            onPressed: () {},
            isTopLeft: false,
            color: AppColors.primaryColor,
            borderColor: AppColors.primaryColor,
            textColor: AppColors.textColor,
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: CustomShapeButton(
            text: "Sell",
            onPressed: () {},
            isTopLeft: true,
            color: AppColors.backgroundColor,
            borderColor: AppColors.secondaryButtonBorderColor,
            textColor: AppColors.whiteTextColor,
          ),
        ),
      ],
    );
  }

  _limitedOrderView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
            width: double.infinity,
            child: ButtonWithIcon(
                leadingIcon: AppImages.infoImageSvg,
                btnText: 'Limited order',
                trailingIcon: AppImages.downArrowImageSvg,
                onTap: () {})),
        SizedBox(
            width: double.infinity,
            child: ButtonWithIcon(
                btnText: '5753.91', trailingText: "BTC", onTap: () {})),
        _paddingHeight,
        PrimaryText(
          text: "=\$57537.91",
          color: AppColors.whiteTextColor,
          size: AppDimen.textSize14,
        ),
        _paddingHeight,
      ],
    );
  }

  _quantityView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
            width: double.infinity,
            child: ButtonWithIcon(
                btnText: '5753.91', trailingText: "BTC", onTap: () {})),
        _paddingHeight,
        PrimaryText(
          text: "=\$57537.91",
          color: AppColors.whiteTextColor,
          size: AppDimen.textSize14,
        ),
      ],
    );
  }

  _totalView() {
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            child: ButtonWithIcon(
                btnText: 'Total', trailingText: "USDT", onTap: () {})),
        _paddingHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryText(
              text: "Available",
              color: AppColors.whiteTextColor,
            ),
            Row(
              children: [
                PrimaryText(
                  text: "0 USDT",
                  color: AppColors.whiteTextColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                AppImages.plusImageSvg.toSvgImage(height: 20, width: 20),
              ],
            ),
          ],
        ),
        _paddingHeight,
      ],
    );
  }

  _buyBTCView() {
    return SizedBox(
        width: double.infinity,
        child: PrimaryButton(btnText: "Buy BTC", onTap: () {}));
  }

  _tableTotalView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            PrimaryText(
              text: "5793.1",
              color: AppColors.whiteTextColor,
              size: AppDimen.textSize18,
            ),
            const SizedBox(
              height: 3,
            ),
            PrimaryText(
              text: "=\$5793.1",
              color: AppColors.whiteTextColor,
              size: AppDimen.textSize14,
            ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        AppImages.rightArrowImageSvg.toSvgImage(),
      ],
    );
  }

  _tablePriceView(bool isFromPositive, Map orderBookMap) {
    return Column(
      children: [
        if (!isFromPositive)
          _tableHeaderView(
            title: "Price",
            subTitle: "(USTD)",
          ),
        if (isFromPositive)
          ...orderBookMap.entries.expand((entry) {
            if (entry.key == "asks" && entry.value is List) {
              return entry.value.map((e) => PrimaryText(
                    text: "${e["price"]}",
                    color: AppColors.greenTextColor,
                    size: AppDimen.textSize14,
                  ));
            }
            return [const SizedBox.shrink()];
          }).toList()
        else
          ...orderBookMap.entries.expand((entry) {
            if (entry.key == "bids" && entry.value is List) {
              return entry.value.map((e) => PrimaryText(
                    text: "${e["price"]}",
                    color: AppColors.redTextColor,
                    size: AppDimen.textSize14,
                  ));
            }
            return [SizedBox.shrink()];
          }).toList()
      ],
    );
  }

  _tableQuantityView(bool isFromPositive, Map orderBookMap) {
    return Column(
      children: [
        if (!isFromPositive)
          _tableHeaderView(
            title: "Quantity",
            subTitle: "(BTC)",
          ),
        if (isFromPositive)
          ...orderBookMap.entries.expand((entry) {
            if (entry.key == "asks" && entry.value is List) {
              return entry.value.map((element) => PrimaryText(
                    text: "${element["amount"]}",
                    color: AppColors.whiteTextColor,
                    size: AppDimen.textSize14,
                  ));
            }
            return [
              const SizedBox.shrink()
            ];
          }).toList()
        else
          ...orderBookMap.entries.expand((entry) {
            if (entry.key == "bids" && entry.value is List) {
              return entry.value.map((element) => PrimaryText(
                    text: "${element["amount"]}",
                    color: AppColors.whiteTextColor,
                    size: AppDimen.textSize14,
                  ));
            }
            return [
              const SizedBox.shrink()
            ];
          }).toList()
      ],
    );
  }

  _tableHeaderView({required String title, required String subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PrimaryText(text: title, color: AppColors.whiteTextColor),
        PrimaryText(
          text: subTitle,
          color: AppColors.whiteTextColor,
        ),
        _paddingHeight,
      ],
    );
  }
}
