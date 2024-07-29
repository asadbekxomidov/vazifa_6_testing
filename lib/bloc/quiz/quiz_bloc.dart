import 'package:bloc/bloc.dart';
import 'package:vazifa_6_testing/bloc/quiz/quiz_event.dart';
import 'package:vazifa_6_testing/bloc/quiz/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizState.initial()) {
    on<LoadQuizzes>((event, emit) {});

    on<SubmitAnswer>((event, emit) {});

    on<CheckAnswer>((event, emit) {
      final isCorrect =
          state.quizzes[state.currentQuizIndex].answer == event.enteredAnswer;
      emit(state.copyWith(isCorrect: isCorrect));
    });

    on<NextQuiz>((event, emit) {
      final nextIndex = state.currentQuizIndex + 1;
      if (nextIndex < state.quizzes.length) {
        emit(state.copyWith(currentQuizIndex: nextIndex, isCorrect: false));
      }
    });
  }
}
