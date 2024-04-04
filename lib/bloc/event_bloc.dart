part of 'app_bloc.dart';

class AppEvent extends Equatable {
  @override
  List<Object?> get props => [];

}

class AppEventLoading extends AppEvent{
  final String text;
  final String route;
  final Map<String,dynamic> data;
  AppEventLoading(this.text, this.route, this.data);
}