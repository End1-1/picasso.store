import 'package:picassostore/utils/prefs.dart';
import 'package:picassostore/utils/styles.dart';
import 'package:flutter/material.dart';

import 'app.dart';

class WMConfig extends WMApp {
  WMConfig({super.key, required super.model});

  @override
  Widget body() {
    return SingleChildScrollView(child:  Column(children: [
      Styling.columnSpacingWidget(),
      Row(
        children: [
          Expanded(
              child: Styling.textFormField(
                  model.serverTextController, model.tr('Server address'))),
        ],
      ),
      Styling.columnSpacingWidget(),
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Styling.textButton(model.registerDemoServer, locale().useDemoServer)
          ]),
      Styling.columnSpacingWidget(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Styling.textButton(model.registerOnServer, locale().saveServerAddress)
      ]),
      Styling.columnSpacingWidget(),
      Row(children: [
        Expanded(child: Styling.textCenter(prefs.string('appversion')))
      ],),
      Styling.columnSpacingWidget(),
      Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Styling.textButton(model.downloadLatestVersion, model.tr('Download latest version'))
          ]
      ),
    ]));
  }
}
