import 'package:flutter/material.dart';
import 'package:quiz_app/screens/question_and_answer_screen.dart';
import 'package:quiz_app/screens/score_screen.dart';
import 'package:quiz_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Quiz App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text('Error Connecting')),
                );
              }
              return WelcomeScreen();
            }),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case WelcomeScreen.routeName:
              return PageTransition(
                child: QuestionAndAnswerScreen(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case QuestionAndAnswerScreen.routeName:
              return PageTransition(
                child: QuestionAndAnswerScreen(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case ScoreScreen.routeName:
              return PageTransition(
                child: ScoreScreen(),
                type: PageTransitionType.topToBottom,
                settings: settings,
              );
              break;
            default:
              return null;
          }
        });
  }
}
