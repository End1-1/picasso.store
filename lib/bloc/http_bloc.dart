import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picassostore/bloc/app_bloc.dart';
import 'package:picassostore/utils/http_query.dart';

class HttpState extends AppState {
  int state = 0;
  final dynamic data;
  final String mark;

  HttpState({required this.state, required this.data, required this.mark});

  @override
  List<Object?> get props => [id, state, data];
}

class HttpEvent extends AppEvent {
  final Map<String, dynamic> params;
  final String mark;

  HttpEvent(this.params, this.mark);
}

class HttpBloc extends Bloc<HttpEvent, HttpState> {
  HttpBloc() : super(HttpState(state: 0, data: null, mark: '')) {
    on<HttpEvent>(_load);
  }

  Future<void> _load(HttpEvent e, Emitter<HttpState> emit) async {
    emit(HttpState(state: 3, data: null, mark: e.mark));
    final reply = await HttpQuery('engine/picasso.store/').request((e.params));
    final newState = HttpState(
        state: reply['status'] == 1 ? 2 : 1, data: reply['data'], mark: e.mark);
    emit(newState);
  }
}
