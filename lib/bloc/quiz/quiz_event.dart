import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class LoadQuizzes extends QuizEvent {}

class SubmitAnswer extends QuizEvent {
  final String answer;

  const SubmitAnswer(this.answer);

  @override
  List<Object> get props => [answer];
}

class CheckAnswer extends QuizEvent {
  final String enteredAnswer;

  const CheckAnswer(this.enteredAnswer);

  @override
  List<Object> get props => [enteredAnswer];
}

class NextQuiz extends QuizEvent {}
