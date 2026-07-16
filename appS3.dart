import 'package:flutter/material.dart';
import 'Quiz.dart';
import 'Score.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      home: const QuizHome(),
    );
  }
}

class QuizHome extends StatefulWidget {
  const QuizHome({Key? key}) : super(key: key);

  @override
  State<QuizHome> createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  var _questionIndex = 0;
  var _totalScore = 0;

  final _questions = const [
    {
      'questionText': 'Q 1 - Which of the following is correct about Java 8 lambda expression ?',
      'answers': [
        {'text': 'A - Using lambda expression, you can refer to final variable or effectively final variable (which is assigned only once)', 'score': 1},
        {'text': 'B - Lambda expression throws a compilation error, if a variable is assigned a value the second time ?', 'score': 0},
        {'text': 'C - Both of the above.', 'score': 0},
        {'text': 'D - None of the above.', 'score': 0},
      ],
    },
    {
      'questionText': 'Q 8 - Which of the following is the correct lambda expression which add two numbers and return their sum?',
      'answers': [
        {'text': 'A - (int a, int b) -> { return a + b; };', 'score': 0},
        {'text': 'B - (a, b) -> { return a + b; };', 'score': 0},
        {'text': 'C - Both of the above.', 'score': 1},
        {'text': 'D - None of the above.', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
              questions: _questions,
            )
          : Score(
              score: _totalScore,
              totalQuestions: _questions.length,
              resetHandler: _resetQuiz,
            ),
    );
  }
}