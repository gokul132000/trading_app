import 'package:flutter/cupertino.dart';


import '../../../../utiles/globals.dart' as globals;

class TradeViewRepository {
  static TradeViewRepository? _instance;

  factory TradeViewRepository() {
    return _instance ??= TradeViewRepository._internal();
  }
  TradeViewRepository._internal();

  listenDataOrderBookSocket(ValueChanged<Map> onValueChanged){
    globals.socketService.onEvent('OrderBook', (data) {
      onValueChanged(data["data"]);
    });
  }

  sendDataGetOrderBook(){
    globals.socketService.emitEvent('GetOrderBook', {'symbol': 'ETH/USDC'});
  }

}
