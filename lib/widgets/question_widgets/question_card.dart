import 'dart:async';

import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String questionText;
  final int currentQuestion;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final Function notAttempted;

  QuestionCard(
      {Key key,
      this.questionText,
      this.currentQuestion,
      this.totalQuestions,
      this.correctAnswers,
      this.wrongAnswers,
      this.notAttempted})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      shape: RoundedRectangleBorder(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: AnswerCount(
                          color: Colors.green,
                          numAnswers: correctAnswers,
                          totalQuestions: totalQuestions),
                    ),
                    CircleAvatar(
                      child: TimeLeft(
                        notAttempted: notAttempted,
                        startValue: 30,
                      ),
                    ),
                    Flexible(
                      child: AnswerCount(
                          color: Colors.red,
                          numAnswers: wrongAnswers,
                          totalQuestions: totalQuestions),
                    )
                  ],
                ),
                Text(
                  'Question ${currentQuestion + 1}/$totalQuestions',
                  textAlign: TextAlign.center,
                ),
                Text('$questionText')
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AnswerCount extends StatelessWidget {
  final int numAnswers;
  final Color color;
  final int totalQuestions;

  const AnswerCount({Key key, this.numAnswers, this.color, this.totalQuestions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      color == Colors.green ? '$numAnswers correct' : '$numAnswers wrong',
      style: TextStyle(color: color),
    ));
  }
}

class TimeLeft extends StatefulWidget {
  final notAttempted;
  var startValue;

  TimeLeft({Key key, this.notAttempted, this.startValue}) : super(key: key);
  @override
  _TimeLeftState createState() => _TimeLeftState();
}

class _TimeLeftState extends State<TimeLeft> {
  Timer t;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  startTimer() {
    t = Timer.periodic(Duration(seconds: 1), (_) {
      if (widget.startValue == 0) {
        widget.notAttempted();
        return;
      }
      setState(() {
        widget.startValue -= 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('${widget.startValue}');
  }
}
