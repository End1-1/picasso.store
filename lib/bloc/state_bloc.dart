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