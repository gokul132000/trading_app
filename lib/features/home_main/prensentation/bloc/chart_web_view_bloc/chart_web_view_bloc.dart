import 'package:flutter/material.dart';

import 'chart_web_view_event.dart';
import 'chart_web_view_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:trading_app/utiles/globals.dart' as globals;

class ChartWebViewBloc extends Bloc<ChartWebViewEvent, ChartWebViewState> {
  late final WebViewController _controller;

  ChartWebViewBloc() : super(ChartWebViewStateInitial()) {
    on<ChartWebViewEventInit>(_initWebView);
  }

  void _initWebView(ChartWebViewEventInit event, Emitter<ChartWebViewState> emit) async {
    emit(ChartWebViewStateLoading());
    try {
      // Initialize WebViewController
      late final PlatformWebViewControllerCreationParams params;
      if (WebViewPlatform.instance is WebKitWebViewPlatform) {
        params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
        );
      } else {
        params = const PlatformWebViewControllerCreationParams();
      }

      final WebViewController controller =
      WebViewController.fromPlatformCreationParams(params);

      controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onWebResourceError: (WebResourceError error) {
              emit(ChartWebViewStateError(error.description));
            },
          ),
        )
        ..loadRequest(Uri.parse(globals.webChartURL))
        ..addJavaScriptChannel(
          'Toaster',
          onMessageReceived: (JavaScriptMessage message) {
            debugPrint('JavaScript Message: ${message.message}');
          },
        );
      _controller = controller;
      emit(ChartWebViewStateLoaded());
    } catch (e) {
      emit(ChartWebViewStateError(e.toString()));
    }
  }


  WebViewController get controller => _controller;
}
