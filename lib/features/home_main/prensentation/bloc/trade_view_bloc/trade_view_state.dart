abstract class TradeViewState {
  const TradeViewState();
}

class TradeViewStateStarted extends TradeViewState {
  const TradeViewStateStarted();
}

class TradeViewStateFetchData extends TradeViewState {
  const TradeViewStateFetchData();
}

class TradeViewStateLoading extends TradeViewState {
  const TradeViewStateLoading();
}

class TradeViewStateLoaded extends TradeViewState {
  const TradeViewStateLoaded();
}

class TradeViewStateNoDataFound extends TradeViewState {
  const TradeViewStateNoDataFound();
}
