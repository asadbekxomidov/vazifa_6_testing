import 'package:equatable/equatable.dart';

class QuizState extends Equatable {
  final List<Quiz> quizzes;
  final int currentQuizIndex;
  final bool isCorrect;

  const QuizState({
    required this.quizzes,
    required this.currentQuizIndex,
    required this.isCorrect,
  });

  factory QuizState.initial() {
    return QuizState(
      quizzes: [
        Quiz(
            images: ['apple1.png', 'apple2.png', 'apple3.png', 'apple4.png'],
            answer: 'apple'),
        Quiz(
            images: ['banan1.png', 'banan2.png', 'banan3.png', 'banan4.png'],
            answer: 'banana'),
        Quiz(images: [
          'cherry1.png',
          'cherry2.png',
          'cherry3.png',
          'cherry4.png'
        ], answer: 'juice'),
        Quiz(
            images: ['sport1.png', 'sport2.png', 'sport3.png', 'sport4.png'],
            answer: 'sports'),
      ],
      currentQuizIndex: 0,
      isCorrect: false,
    );
  }

  QuizState copyWith({
    List<Quiz>? quizzes,
    int? currentQuizIndex,
    bool? isCorrect,
  }) {
    return QuizState(
      quizzes: quizzes ?? this.quizzes,
      currentQuizIndex: currentQuizIndex ?? this.currentQuizIndex,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  List<Object> get props => [quizzes, currentQuizIndex, isCorrect];
}

class Quiz {
  final List<String> images;
  final String answer;

  Quiz({
    required this.images,
    required this.answer,
  });
}
