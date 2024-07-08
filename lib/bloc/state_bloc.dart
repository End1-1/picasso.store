part of 'app_bloc.dart';

class AppState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStateLoading extends AppState {
  final String text;

  AppStateLoading(this.text);
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
