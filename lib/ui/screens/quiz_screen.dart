import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa_6_testing/bloc/quiz/quiz_bloc.dart';
import 'package:vazifa_6_testing/bloc/quiz/quiz_event.dart';
import 'package:vazifa_6_testing/bloc/quiz/quiz_state.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizBloc()..add(LoadQuizzes()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state.quizzes.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            final currentQuiz = state.quizzes[state.currentQuizIndex];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: currentQuiz.images.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      'assets/images/${currentQuiz.images[index]}',
                      width: 80,
                      height: 80,
                      key: Key(currentQuiz.images[index]),
                    );
                  },
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 8.0,
                  children: List.generate(currentQuiz.answer.length, (index) {
                    final char = currentQuiz.answer[index];
                    return ElevatedButton(
                      key: Key('button_${char}_$index'),
                      onPressed: () {
                        context.read<QuizBloc>().add(SubmitAnswer(char));
                      },
                      child: Text(char),
                    );
                  }),
                ),
                SizedBox(height: 20),
                TextButton(
                  key: Key('submitAnswer'),
                  onPressed: () {
                    final enteredAnswer = currentQuiz.answer;
                    context.read<QuizBloc>().add(CheckAnswer(enteredAnswer));
                  },
                  child: Text('Submit Answer'),
                ),
                if (state.isCorrect != null)
                  Column(
                    children: [
                      Text(
                        state.isCorrect ? 'Correct!' : 'Try Again!',
                        key: Key('resultText'),
                      ),
                      if (state.isCorrect)
                        TextButton(
                          key: Key('nextQuiz'),
                          onPressed: () {
                            context.read<QuizBloc>().add(NextQuiz());
                          },
                          child: Text('Next Quiz'),
                        ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}


