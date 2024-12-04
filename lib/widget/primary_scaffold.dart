import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trading_app/resource/app_colors.dart';
import 'package:trading_app/resource/app_dimension.dart';
import 'package:trading_app/resource/app_font.dart';
import 'package:trading_app/widget/primary_text.dart';

class PrimaryScaffold extends StatefulWidget {
  Widget? body;
  Color backgroundColor;
  Function? primaryInitFunction;
  Function? primaryDisposeFunction;
  Widget? floatingActionButton;
  PreferredSizeWidget? appBrBottom;
  FloatingActionButtonLocation? floatingActionButtonLocation;
  String appBarTitle;
  List<Widget>? action;
  Widget? bottomNavigationBar;
  PrimaryScaffold({super.key,this.appBarTitle = '',this.body,this.backgroundColor = AppColors.backgroundColor,this.primaryInitFunction,this.primaryDisposeFunction,this.floatingActionButton,this.floatingActionButtonLocation,this.appBrBottom,this.action,this.bottomNavigationBar});

  @override
  State<PrimaryScaffold> createState() => _PrimaryScaffoldState();
}

class _PrimaryScaffoldState extends State<PrimaryScaffold> {
  @override
  void initState() {
    if(widget.primaryInitFunction != null) {
      widget.primaryInitFunction;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
          floatingActionButton: widget.floatingActionButton,
          backgroundColor: widget.backgroundColor,
          appBar:widget.appBarTitle.isEmpty ? null : AppBar(
            toolbarHeight: 80.0,
            foregroundColor: AppColors.primaryColor,
            bottom: widget.appBrBottom,
            backgroundColor: AppColors.backgroundColor,
            title: PrimaryText(
              text: widget.appBarTitle,
              color: AppColors.primaryColor,
              size: AppDimen.textSize20,
              weight: AppFont.bold,
            ),
            centerTitle: true,
            actions: widget?.action ?? [],
          ),
          body: widget.body ?? const SizedBox.shrink(),
            bottomNavigationBar: widget.bottomNavigationBar,
        )
    );
  }

  @override
  void dispose() {
    if(widget.primaryDisposeFunction != null) {
      widget.primaryDisposeFunction;
    }
    super.dispose();
  }
}
