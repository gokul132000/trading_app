abstract class ChartWebViewEvent {}

class ChartWebViewEventInit extends ChartWebViewEvent {}

class ChartWebViewEventLoadUrl extends ChartWebViewEvent {
  final String url;

  ChartWebViewEventLoadUrl(this.url);
}
