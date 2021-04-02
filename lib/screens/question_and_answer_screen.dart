import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/QuestionModel.dart';
import 'package:quiz_app/screens/score_screen.dart';
import 'package:quiz_app/widgets/answer_card.dart';
import 'package:quiz_app/widgets/question_widgets/question_card.dart';

class QuestionAndAnswerScreen extends StatefulWidget {
  static const routeName = '/question-screen';

  @override
  _QuestionAndAnswerScreenState createState() =>
      _QuestionAndAnswerScreenState();
}

class _QuestionAndAnswerScreenState extends State<QuestionAndAnswerScreen> {
  final List<QuestionModel> _questions = [];
  bool fetchingQuestions;
  int _currentIndex = 0;
  int wrongAnswers = 0;
  int correctAnswers = 0;
  String username;
  @override
  void initState() {
    fetchingQuestions = true;
    fetchQuestions();
    super.initState();
  }

  fetchQuestions() async {
    final questionsSnapshot =
        await FirebaseFirestore.instance.collection('questions').get();

    questionsSnapshot.docs.forEach((doc) {
      _questions.add(QuestionModel.fromQueryDocumentSnapshot(doc));
    });
    setState(() {
      fetchingQuestions = false;
    });
  }

  _notAttempted() {
    _submitFn(false);
  }

  _submitFn(bool correct) {
    setState(() {
      correct ? correctAnswers++ : wrongAnswers++;
      if (_currentIndex + 1 == _questions.length) {
        Navigator.of(context).popAndPushNamed(ScoreScreen.routeName,
            arguments: [correctAnswers, wrongAnswers, username]);
        return;
      }
      _currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    username = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Hello $username'),
      ),
      body: fetchingQuestions
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: QuestionCard(
                      currentQuestion: _currentIndex,
                      correctAnswers: correctAnswers,
                      questionText: _questions[_currentIndex].question,
                      totalQuestions: _questions.length,
                      wrongAnswers: wrongAnswers,
                      notAttempted: _notAttempted,
                    ),
                  ),
                ),
                Flexible(flex: 1, child: SizedBox.expand()),
                Flexible(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: AnswerCard(
                        submit: _submitFn,
                        options: _questions[_currentIndex].options,
                        correctIndex: _questions[_currentIndex].answer),
                  ),
                ),
                Flexible(flex: 1, child: SizedBox.expand()),
              ],
            ),
    );
  }
}
