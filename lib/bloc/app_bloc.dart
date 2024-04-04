import 'package:cafe5_mworker/utils/http_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'event_bloc.dart';
part 'state_bloc.dart';

class AppBloc extends Bloc<AppEvent,AppState> {
  AppBloc() : super(AppState()) {
    on<AppEventLoading>((event, emit) => loadingData(event));
    on<AppEvent>((event, emit) => emit(AppState()));
  }

  void loadingData(AppEventLoading event) async {
    emit(AppStateLoading(event.text));
    final result = await HttpQuery(event.route).request(event.data);
    emit(AppState());
    if (result['status'] == 0) {
      emit(AppStateError(result['data']));
    }
  }
}