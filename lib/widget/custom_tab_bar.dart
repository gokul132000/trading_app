import 'package:flutter/material.dart';
import 'package:trading_app/resource/app_dimension.dart';
import 'package:trading_app/widget/commig_soon.dart';
import 'package:trading_app/widget/primary_text.dart';

import '../resource/app_colors.dart';

Map _priceTableMap = {
  0: {
    "pair": "BTC/UTSC",
    "price": "0.000",
    "side": "Buy",
    "type": "Limit",
    "amount": "0.000",
    "action": "Cancel"
  },
  1: {
    "pair": "BTC/UTSC",
    "price": "0.000",
    "side": "Sell",
    "type": "Market",
    "amount": "0.000",
    "action": "Cancel"
  },
  2: {
    "pair": "BTC/UTSC",
    "price": "0.000",
    "side": "Sell",
    "type": "Market",
    "amount": "0.000",
    "action": "Cancel"
  },
  4: {
    "pair": "BTC/UTSC",
    "price": "0.000",
    "side": "Sell",
    "type": "Market",
    "amount": "0.000",
    "action": "Cancel"
  },
  5: {
    "pair": "BTC/UTSC",
    "price": "0.000",
    "side": "Buy",
    "type": "Limit",
    "amount": "0.000",
    "action": "Cancel"
  },
  6: {
    "pair": "BTC/UTSC",
    "price": "0.000",
    "side": "Buy",
    "type": "Limit",
    "amount": "0.000",
    "action": "Cancel"
  },
  7: {
    "pair": "BTC/UTSC",
    "price": "0.000",
    "side": "Buy",
    "type": "Limit",
    "amount": "0.000",
    "action": "Cancel"
  },
  8: {
    "pair": "BTC/UTSC",
    "price": "0.000",
    "side": "Sell",
    "type": "Market",
    "amount": "0.000",
    "action": "Cancel"
  },
  9: {
    "pair": "BTC/UTSC",
    "price": "0.000",
    "side": "Sell",
    "type": "Market",
    "amount": "0.000",
    "action": "Cancel"
  },
  10: {
    "pair": "BTC/UTSC",
    "price": "0.000",
    "side": "Sell",
    "type": "Market",
    "amount": "0.000",
    "action": "Cancel"
  },
  11: {
    "pair": "BTC/UTSC",
    "price": "0.000",
    "side": "Buy",
    "type": "Limit",
    "amount": "0.000",
    "action": "Cancel"
  },
};

class CustomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 500,
      child: DefaultTabController(
        length: 3,
        child: Column(

          mainAxisSize: MainAxisSize.min,
          children: [
            const TabBar(
              labelColor: AppColors.yellowColor,
              indicatorColor: AppColors.yellowColor,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(text: "Orders",),
                Tab(text: "Order history"),
                Tab(text: "Cancel order"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      _buildTableRow("Pair", "Price", "Side","Type","Amount","Action", isHeader: true),
                      Expanded(
                        child: ListView(
                          children:  _priceTableMap.values.map((e)=>
                              _buildTableRow(e["pair"].toString(), e["price"].toString(), e["side"].toString(),e["type"].toString(),e["amount"].toString(),e["action"].toString()),
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                  ComingSoonWidget(),
                  ComingSoonWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(String col1, String col2, String col3,String col4,String col5,col6, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: AppColors.backgroundColor,
      child: Row(
        children: [
          _customText(isHeader, col1),
          _customText(isHeader, col2),
          _customText(isHeader, col3,col3 == "Buy" ? AppColors.redTextColor :  col3 == "Sell" ? AppColors.greenTextColor : AppColors.whiteTextColor),
          _customText(isHeader, col4),
          _customText(isHeader, col5),
          _customText(isHeader, col6, isHeader ? AppColors.whiteTextColor  : AppColors.redTextColor),
        ],
      ),
    );
  }

  _customText(bool isHeader,String col,[Color color = AppColors.whiteTextColor]){
    return   Expanded(child: PrimaryText(text: col, weight: isHeader ? FontWeight.bold : FontWeight.normal,color: color,size: AppDimen.textSize14,));
  }


}

