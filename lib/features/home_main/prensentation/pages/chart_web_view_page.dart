import 'package:flutter/material.dart';

import '../../../../widget/primary_scaffold.dart';
import '../bloc/chart_web_view_bloc/chart_web_view_bloc.dart';
import '../bloc/chart_web_view_bloc/chart_web_view_event.dart';
import '../bloc/chart_web_view_bloc/chart_web_view_state.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartWebViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChartWebViewBloc()..add(ChartWebViewEventInit()),
      child: ChartWebViewPageState(),
    );
  }
}

class ChartWebViewPageState extends StatefulWidget {
  @override
  _ChartWebViewPageStateState createState() => _ChartWebViewPageStateState();
}

class _ChartWebViewPageStateState extends State<ChartWebViewPageState> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartWebViewBloc, ChartWebViewState>(
      builder: (context, state) {
        if (state is ChartWebViewStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChartWebViewStateLoaded) {
          final bloc = context.read<ChartWebViewBloc>();
          return PrimaryScaffold(
            body: WebViewWidget(controller: bloc.controller),
          );
        } else if (state is ChartWebViewStateError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
