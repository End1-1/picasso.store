import 'package:cafe5_mworker/bloc/app_bloc.dart';
import 'package:cafe5_mworker/screen/config.dart';
import 'package:cafe5_mworker/utils/http_query.dart';
import 'package:cafe5_mworker/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/model.dart';
import 'model/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(
      MultiBlocProvider(
          providers: [BlocProvider<AppBloc>(create: (context) => AppBloc())],
          child:
      App()));
}

class App extends StatefulWidget {
  final model = WMModel();
  App({super.key});

  @override
  State<StatefulWidget> createState()=> _App();
}

class _App extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        navigatorKey: Prefs.navigatorKey,
        home: Scaffold(
            body: SafeArea(
                child: FutureBuilder<String>(
                  future: init(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Container(
                          color: Colors.white,
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Text(snapshot.error.toString()),
                                IconButton(onPressed: (){Navigation(widget.model).config();}, icon: Icon(Icons.arrow_forward))]));
                    }
                    return Container(
                        color: Colors.white,
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator());
                  },
                ))));
  }

  Future<String> init() async {
    if (prefs.string('serveraddress').isEmpty) {
      return Future.error('Please, configure server addresss');
    }
    final response = await HttpQuery('/engine/clientconfig.php').request({});
    print(response);
    return "OK";
  }
  
}
