import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/bloc/question_bloc.dart';
import 'package:cafe5_mworker/model/model.dart';
import 'package:cafe5_mworker/model/navigation.dart';
import 'package:cafe5_mworker/screen/menu.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:cafe5_mworker/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WMApp extends StatelessWidget {
  late final Navigation nav;
  final WMModel model;

  WMApp({super.key, required this.model}) {
    nav = Navigation(model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styling.appBarBackgroundColor,
        leading: leadingButton(context),
        title: _title(),
        centerTitle: true,
        actions: actions(),
      ),
      body: SafeArea(
        //minimum: const EdgeInsets.fromLTRB(5, 10, 5, 2),
        child: Stack(children: [
          Container(padding: const EdgeInsets.all(5), child: body()),
          BlocBuilder<AppBloc, AppState>(builder: (context, state) {
            if (state is AppStateLoading) {
              return loading(state.text);
            } else {
              return Container();
            }
          }),
          BlocBuilder<AppBloc, AppState>(builder: (context, state) {
            if (state is AppStateError) {
              return errorDialog(state.text);
            }
            return Container();
          }),
          WMAppMenu(model, menuWidgets()),
          BlocBuilder<QuestionBloc, QuestionState>(builder: (builder, state){
            if (state is QuestionStateRaise) {
              return questionDialog(state.question, state.ifYes, state.ifNo);
            }
            return Container();
          }
          )
        ]),
      ),
    );
  }

  Widget? leadingButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String titleText() {
    return 'Picasso';
  }

  Widget _title() {
    return Text(titleText(),
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Color(0xff89ff00), fontSize: 14));
  }

  List<Widget> actions() {
    if (menuWidgets().isEmpty) {
      return [];
    }
    return [
      IconButton(
          onPressed: () {
            BlocProvider.of<AppAnimateBloc>(prefs.context())
                .add(AppAnimateEventRaise());
          },
          icon: Icon(Icons.menu_sharp)),
    ];
  }

  List<Widget> menuWidgets() {
    return [];
  }

  Widget body();

  Widget loading(String text) {
    return Container(
      height: MediaQuery.sizeOf(prefs.context()).height,
        width: MediaQuery.sizeOf(prefs.context()).width,
        color: Colors.black26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                  height: 30, width: 30, child: CircularProgressIndicator()),
              Styling.columnSpacingWidget(),
              Styling.text(text)
            ],
          ),
        );
  }

  Widget errorDialog(String text) {
    return Container(
        color: Colors.black26,
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    Styling.columnSpacingWidget(),
                    Container(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.sizeOf(prefs.context()).height *
                                    0.7),
                        child: SingleChildScrollView(
                            child: Styling.textCenter(text))),
                    Styling.columnSpacingWidget(),
                    Styling.textButton(model.closeDialog, model.tr('Close'))
                  ],
                ),
              )
            ])));
  }

  Widget questionDialog(String text, VoidCallback ifYes, VoidCallback? ifNo) {
    return Container(
        color: Colors.black26,
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.question_answer_outlined,
                      color: Colors.green,
                    ),
                    Styling.columnSpacingWidget(),
                    Container(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.sizeOf(prefs.context()).height *
                                    0.7),
                        child: SingleChildScrollView(
                            child: Styling.textCenter(text))),
                    Styling.columnSpacingWidget(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                        children: [
                      Styling.textButton(ifYes, model.tr('Yes')),
                      Styling.textButton(ifNo ?? model.closeQuestionDialog, model.tr('Cancel'))
                    ])
                  ],
                ),
              )
            ])));
  }
}
