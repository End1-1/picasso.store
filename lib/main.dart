import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:picassostore/bloc/app_bloc.dart';
import 'package:picassostore/bloc/app_cubits.dart';
import 'package:picassostore/bloc/date_bloc.dart';
import 'package:picassostore/bloc/http_bloc.dart';
import 'package:picassostore/bloc/question_bloc.dart';
import 'package:picassostore/model/new_order_model.dart';
import 'package:picassostore/screen/login.dart';
import 'package:picassostore/screen/new_partner.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:picassostore/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'model/goods.dart';
import 'model/model.dart';
import 'model/navigation.dart';
import 'model/partner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  PackageInfo pa = await PackageInfo.fromPlatform();
  prefs.setString('appversion', '${pa.version}.${pa.buildNumber}');
  prefs.init();
  await Hive.initFlutter();
  Hive.registerAdapter(NewOrderModelAdapter());
  Hive.registerAdapter(PartnerAdapter());
  Hive.registerAdapter(GoodsAdapter());
  await Hive.openBox<NewOrderModel>('orderBox');

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AppBloc>(create: (context) => AppBloc()),
    BlocProvider<InitAppBloc>(
        create: (context) => InitAppBloc()..add(InitAppEvent())),
    BlocProvider<AppAnimateBloc>(create: (context) => AppAnimateBloc()),
    BlocProvider<DateBloc>(create: (context) => DateBloc()),
    BlocProvider<QuestionBloc>(create: (context) => QuestionBloc()),
    BlocProvider<AppLoadingCubit>(create: (_) => AppLoadingCubit()),
    BlocProvider<AppCubits>(create: (_) => AppCubits()),
    BlocProvider<HttpBloc>(create: (_) => HttpBloc()),
    BlocProvider<CheckCubit>(create:(_)=>CheckCubit())
  ], child: App()));
}

class App extends StatefulWidget {
  final model = WMModel();

  App({super.key}) {
    Prefs.navigatorKey = GlobalKey<NavigatorState>();
  }

  @override
  State<StatefulWidget> createState() => _App();
}

class _App extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Picasso',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        locale: const Locale('hy'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('hy'), Locale('ru')],
        navigatorKey: Prefs.navigatorKey,
        home: Scaffold(
            body: SafeArea(
                child: BlocListener<InitAppBloc, InitAppState>(
                    listener: (context, state) {
          if (state.runtimeType == InitAppState) {
            BlocProvider.of<InitAppBloc>(context).add(InitAppEvent());
          }
          if (state.runtimeType == InitAppStateFinished) {
            if ((prefs.getBool('stayloggedin') ?? false) &&
                prefs.string('sessionkey').isNotEmpty) {
              widget.model.loginPasswordHash();
            }
          }
        }, child: BlocBuilder<InitAppBloc, InitAppState>(
          builder: (context, state) {
            if (prefs.string('serveraddress').isEmpty) {
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    const Text('Please, configure server address'),
                    IconButton(
                        onPressed: () {
                          Navigation(widget.model).config().then((value) {
                            BlocProvider.of<InitAppBloc>(context)
                                .add(InitAppEvent());
                          });
                        },
                        icon: const Icon(Icons.arrow_forward))
                  ]));
            }
            if (state is InitAppStateLoading) {
              return Center(
                child: Container(
                  color: Colors.white,
                  height: 30,
                  width: 30,
                  child: const CircularProgressIndicator(),
                ),
              );
            }
            if (state is InitAppStateFinished) {
              if (state.error) {
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Expanded(child: Container()),
                      Row(children: [
                        Expanded(child: Styling.textError(state.errorText))
                      ]),
                      Styling.columnSpacingWidget(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Styling.textButton(() {
                              BlocProvider.of<InitAppBloc>(context)
                                  .add(InitAppEvent());
                            }, widget.model.tr('Retry'))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Styling.textButton(
                                widget.model.downloadLatestVersion,
                                widget.model.tr('Download latest version'))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Styling.textButton(widget.model.navigation.settings,
                                widget.model.tr('Setting'))
                          ]),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Expanded(
                              child: Styling.textCenter(
                                  prefs.string('appversion')))
                        ],
                      )
                    ]));
              }
              return Center(
                  child: WMLogin(widget.model, WMLogin.username_password));
            }
            return Container();
          },
        )))));
  }
}
