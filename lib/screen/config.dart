import 'package:cafe5_mworker/utils/styles.dart';
import 'package:flutter/material.dart';

import 'app.dart';

class WMConfig extends MWApp {
  WMConfig({super.key, required super.model});

  @override
  Widget body() {
    return Column(children: [
      Row(
        children: [
          Expanded(
              child: Styling.textFormField(
                  model.serverTextController, model.tr('Server address'))),
        ],
      ),
      Styling.columnSpacingWidget(),
      Row(children: [
        Expanded(
            child: Styling.textFormField(
                model.serverUserTextController, model.tr('Server user')))
      ]),
      Styling.columnSpacingWidget(),
      Row(children: [
        Expanded(
            child: Styling.textFormField(model.serverPasswordTextController,
                model.tr('Server password')))
      ]),
      Styling.columnSpacingWidget(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Styling.textButton(model.registerOnServer, model.tr('Register on server'))
      ])
    ]);
  }
}
