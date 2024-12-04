import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_app/features/home_main/prensentation/pages/trade_view_page.dart';
import 'package:trading_app/resource/app_dimension.dart';
import 'package:trading_app/widget/primary_scaffold.dart';
import '../../../../resource/app_colors.dart';
import '../../../../resource/app_images.dart';
import '../../../../widget/commig_soon.dart';
import '../bloc/home_main_bloc/home_main_bloc.dart';
import '../bloc/home_main_bloc/home_main_event.dart';
import '../bloc/home_main_bloc/home_main_state.dart';
import 'package:trading_app/utiles/extension.dart';

import 'chart_web_view_page.dart';

class HomeMainPage extends StatelessWidget {
  final List<Widget> _pages = [
    ComingSoonWidget(),
    ChartWebViewPage(),
    const TradeViewPage(),
    ComingSoonWidget(),
    ComingSoonWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeMainBloc(),
      child: PrimaryScaffold(
        backgroundColor: AppColors.backgroundColor,
        body: BlocBuilder<HomeMainBloc, HomeMainState>(
          builder: (context, state) {
            return _pages[state.currentIndex];
          },
        ),
        bottomNavigationBar: BlocBuilder<HomeMainBloc, HomeMainState>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state.currentIndex,
              showUnselectedLabels: true,
              unselectedLabelStyle: TextStyle(color: AppColors.whiteTextColor),
              selectedItemColor: AppColors.yellowColor,
              backgroundColor: AppColors.backgroundColor,
              unselectedItemColor: AppColors.whiteIconColor,
              unselectedFontSize: AppDimen.textSize16,
              selectedFontSize: AppDimen.textSize16,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                context.read<HomeMainBloc>().add(HomeMainNavTabChanged(index));
              },
              items: _showBottomNavigationItem(state.currentIndex),
            );
          },
        ),
      ),
    );
  }

  _showBottomNavigationItem(int index) {
    Map<int, dynamic> _items = {
      0: {"icon": AppImages.bottomHomeImageSvg, "label": "Home"},
      1: {"icon": AppImages.bottomMarketsImageSvg, "label": "Markers"},
      2: {"icon": AppImages.bottomTradeImageSvg, "label": "Trade"},
      3: {"icon": AppImages.bottomEarnImageSvg, "label": "Earn"},
      4: {"icon": AppImages.bottomWalletImageSvg, "label": "Assets"},
    };

    return _items.entries.map((element) {
      final isSelected = element.key == index;
      return BottomNavigationBarItem(
        backgroundColor: AppColors.backgroundColor,
        icon: element.value["icon"]
            .toString()
            .toSvgImage(color: isSelected ? AppColors.yellowColor : null),
        label: element.value["label"],
      );
    }).toList();
  }
}
