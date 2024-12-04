abstract class ChartWebViewState {}

class ChartWebViewStateInitial extends ChartWebViewState {}

class ChartWebViewStateLoading extends ChartWebViewState {}

class ChartWebViewStateLoaded extends ChartWebViewState {}

class ChartWebViewStateError extends ChartWebViewState {
  final String message;

  ChartWebViewStateError(this.message);
}
