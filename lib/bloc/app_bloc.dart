import 'package:cafe5_mworker/utils/http_query.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_bloc.dart';
part 'state_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState()) {
    on<AppEventLoading>((event, emit) => loadingData(event));
    on<AppEvent>((event, emit) => emit(AppState()));
  }

  void loadingData(AppEventLoading event) async {
    emit(AppStateLoading(event.text));
    final result = await HttpQuery(event.route).request(event.data);
    emit(AppStateFinished());
    if (result['status'] == 0) {
      emit(AppStateError(result['data']));
    }
    if (event.callback != null) {
      event.callback!(result['status'] == 0, result['data']);
    }
  }
}

class InitAppBloc extends Bloc<InitAppEvent, InitAppState> {
  InitAppBloc() : super(InitAppState()) {
    on<InitAppEvent>((event, emit) => configureClient(event));
  }

  void configureClient(InitAppEvent event) async {
    emit(InitAppStateLoading());
    final result = await HttpQuery('engine/clientconfig.php').request({});
    emit(InitAppStateFinished(result['status'] == 0,
        result['status'] == 0 ? result['data'] : '', result['data']));
  }
}
