import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz_brain.dart';
import 'package:flutter/material.dart';

//Object of QuizBrain Class, because we cant access class directly
QuizBrain quizBrain = QuizBrain();
QuizBrain qqq = QuizBrain();

void main() => runApp(const GoQuiz());

class GoQuiz extends StatelessWidget {
  const GoQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreList = [];

  void checkCorrectAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getAnswer();

    setState(() {
      //quizBrain.isFinished();
      if (quizBrain.isFinished() == true) {
        Alert(context: context, title: "Wooh!!", desc: "Quiz Ended")
            .show();
        quizBrain.resetQuiz();
        scoreList = [];
      } else if (userPickedAnswer == correctAnswer) {
        scoreList.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreList.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      quizBrain.updateQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                //USing Object quizBrain
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.green),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkCorrectAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.red),
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkCorrectAnswer(false);
              },
            ),
          ),
        ),
        Row(children: scoreList)
      ],
    );
  }
}
