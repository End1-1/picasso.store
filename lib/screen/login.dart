import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/model/model.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:cafe5_mworker/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WMLogin extends StatelessWidget {
  static const int username_password = 1;
  static const int pin = 2;
  static const int password_hash = 3;
  final WMModel model;
  final int mode;

  WMLogin(this.model, this.mode);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      if (mode == username_password) {
        return Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.login_outlined, size: 60, color: Colors.green),
                Styling.text( model.tr('Login')),
                Styling.columnSpacingWidget(),
                Row(children: [
                  Expanded(
                      child: Styling.textFormField(
                          model.serverUserTextController, model.tr('Username')))
                ]),
                Styling.columnSpacingWidget(),
                Row(children: [
                  Expanded(
                      child: Styling.textFormFieldPassword(
                          model.serverPasswordTextController,
                          model.tr('Password')))
                ]),
                Styling.columnSpacingWidget(),
                WMCheckbox(model.tr('Stay in'), (b) {
                  prefs.setBool('stayloggedin', b ?? false);
                }, prefs.getBool('stayloggedin') ?? false),
                Styling.columnSpacingWidget(),
                if (state.runtimeType == AppStateLoading) ...[
                  const SizedBox(
                      height: 30, width: 30, child: CircularProgressIndicator())
                ],
                if (state.runtimeType != AppStateLoading) ...[
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Styling.textButton(
                        model.loginUsernamePassword, model.tr('Next'))
                  ])
                ],
                if (state is AppStateError)...[
                  Styling.textError(state.text)
                ]
              ],
            ));
      } else {
        return Container(child: Text('Not implemented'));
      }
    });
  }
}
