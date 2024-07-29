import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vazifa_6_testing/bloc/quiz/quiz_bloc.dart';
import 'package:vazifa_6_testing/bloc/quiz/quiz_state.dart';
import 'package:vazifa_6_testing/ui/screens/quiz_screen.dart';

class MockQuizBloc extends Mock implements QuizBloc {}

class MockQuizState extends Mock implements QuizState {}

void main() {
  late MockQuizBloc mockQuizBloc;
  late MockQuizState mockQuizState;

  setUp(() {
    mockQuizBloc = MockQuizBloc();
    mockQuizState = MockQuizState();

    when(() => mockQuizBloc.state).thenReturn(mockQuizState);
  });

  testWidgets('Test TextButton bosilishi va natija ko\'rsatilishini tekshirish',
      (WidgetTester tester) async {
    when(() => mockQuizState.quizzes).thenReturn([
      Quiz(
        images: ['apple1.png', 'apple2.png', 'apple3.png', 'apple4.png'],
        answer: 'A',
      ),
    ]);
    when(() => mockQuizState.currentQuizIndex).thenReturn(0);
    when(() => mockQuizState.isCorrect).thenReturn(false);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<QuizBloc>(
          create: (_) => mockQuizBloc,
          child: QuizScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    when(() => mockQuizState.isCorrect).thenReturn(true);
    await tester.pump();

    expect(find.byKey(Key('submitAnswer')), findsOneWidget);
    await tester.tap(find.byKey(Key('submitAnswer')));
    await tester.pump();

    expect(find.byKey(Key('resultText')), findsOneWidget);
    expect(find.text('Correct!'), findsOneWidget);

    expect(find.byKey(Key('nextQuiz')), findsOneWidget);

    await tester.tap(find.byKey(Key('nextQuiz')));
    await tester.pump();

    expect(find.byType(Image), findsNWidgets(4));
  });
}
