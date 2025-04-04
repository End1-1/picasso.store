import 'package:flutter/material.dart';
import 'package:picassostore/screen/app.dart';
import 'package:picassostore/utils/prefs.dart';

class DebugInfo extends WMApp {
  DebugInfo({super.key, required super.model});

  @override
  Widget body(BuildContext context) {
    return Column(children: [
      Expanded(
          child: SingleChildScrollView(
              child: ListView.builder(
                  itemCount: Prefs.debugInfo.length,
                  itemBuilder: (context, index) {
                    return Row(children: [
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.black12
                                      : Colors.black26),
                              child: Text(Prefs
                                  .debugInfo[Prefs.debugInfo.length - index])))
                    ]);
                  })))
    ]);
  }
}
