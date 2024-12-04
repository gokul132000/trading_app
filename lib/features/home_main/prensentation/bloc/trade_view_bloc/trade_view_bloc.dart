import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_app/features/home_main/prensentation/bloc/trade_view_bloc/trade_view_event.dart';
import 'package:trading_app/features/home_main/prensentation/bloc/trade_view_bloc/trade_view_state.dart';

import '../../../data/repositories/trade_view_repository.dart';

class TradeViewBloc extends Bloc<TradeViewEvent, TradeViewState> {
  final StreamController<Map> orderBookDataController =
      StreamController.broadcast();

  TradeViewBloc() : super(const TradeViewStateStarted()) {
    on<TradeViewEventInit>(fetchData);
  }

  Future<void> fetchData(state, emit) async {
    TradeViewRepository().sendDataGetOrderBook();
    TradeViewRepository().listenDataOrderBookSocket((value) {
      orderBookDataController.add(value);
    });
    emit(const TradeViewStateLoaded());
  }
}
