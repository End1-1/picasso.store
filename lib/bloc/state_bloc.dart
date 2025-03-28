part of 'app_bloc.dart';

class AppState extends Equatable {
  static int _counter = 0;
  late final int id;
  AppState() {
    _counter++;
    id = _counter;
    if (kDebugMode) {
      print('new state id $id');
    }
  }
  @override
  List<Object?> get props => [id];
}

class AppStateError extends AppState {
  final String text;

  AppStateError(this.text);
}

class AppStateFinished extends AppState {
  dynamic data;
  AppStateFinished({required this.data});
}

class InitAppState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitAppStateLoading extends InitAppState {}

class InitAppStateFinished extends InitAppState {
  final bool error;
  final String errorText;
  final dynamic data;
  InitAppStateFinished(this.error, this.errorText, this.data);
}

class AppAnimateStateIdle extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppAnimateStateRaise extends AppAnimateStateIdle{}

class AppAnimateShowMenu extends AppAnimateStateIdle {}

class AppStateDayEnd extends AppStateFinished {
  AppStateDayEnd({required super.data});
  @override
  List<Object?> get props => [id, data];
}
