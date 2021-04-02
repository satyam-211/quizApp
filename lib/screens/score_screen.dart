import 'package:flutter/material.dart';

import 'package:quiz_app/constants.dart';
import 'package:quiz_app/screens/question_and_answer_screen.dart';
import 'package:quiz_app/screens/welcome_screen.dart';

class ScoreScreen extends StatelessWidget {
  static const routeName = 'score-screen';
  @override
  Widget build(BuildContext context) {
    final List<dynamic> arguments = ModalRoute.of(context).settings.arguments;
    final int correctAnswers = arguments[0];
    final int totalQuestions = arguments[0] + arguments[1];
    final String username = arguments[2];
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  "Score",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: kSecondaryColor),
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  "$correctAnswers/$totalQuestions",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: kSecondaryColor),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${(correctAnswers / totalQuestions) * 100} % completion',
                              style:
                                  Theme.of(context).primaryTextTheme.headline5,
                            ),
                            Text(
                              '$totalQuestions total questions',
                              style:
                                  Theme.of(context).primaryTextTheme.headline5,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '$correctAnswers correct',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline5
                                  .copyWith(color: Colors.green),
                            ),
                            Text(
                              '${arguments[1]} wrong',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline5
                                  .copyWith(color: Colors.red),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(Icons.replay),
                        onPressed: () => Navigator.of(context).popAndPushNamed(
                            QuestionAndAnswerScreen.routeName,
                            arguments: username)),
                    Text('Play Again')
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
