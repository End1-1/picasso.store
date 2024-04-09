import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuestionStateRaise extends QuestionState {
  final String question;
  final VoidCallback ifYes;
  final VoidCallback? ifNo;

  QuestionStateRaise(this.question, this.ifYes, this.ifNo);
}

class QuestionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuestionEventRaise extends QuestionEvent {
  final String question;
  final VoidCallback ifYes;
  final VoidCallback? ifNo;

  QuestionEventRaise(this.question, this.ifYes, this.ifNo);
}

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc() : super(QuestionState()) {
    on<QuestionEvent>((event, emit) => emit(QuestionState()));
    on<QuestionEventRaise>(
        (event, emit) => emit(QuestionStateRaise(event.question, event.ifYes, event.ifNo)));
  }
}
