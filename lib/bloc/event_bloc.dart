part of 'app_bloc.dart';

class AppEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppEventLoading extends AppEvent {
  final String text;
  final String route;
  final Map<String, dynamic> data;
  final Function(bool, dynamic)? callback;

  AppEventLoading(this.text, this.route, this.data, this.callback);
}

class AppEventError extends AppEvent {
  final String text;
  AppEventError(this.text);
}

class InitAppEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppAnimateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppAnimateEventRaise extends AppAnimateEvent {}