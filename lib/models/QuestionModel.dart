import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  final int id, answer;
  final String question;
  final List<String> options;

  QuestionModel({this.id, this.question, this.answer, this.options});

  factory QuestionModel.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot querySnapshot) {
    List<String> options = [];
    querySnapshot['options'].forEach((option) => options.add(option));
    return QuestionModel(
        id: querySnapshot['id'],
        question: querySnapshot['question'],
        answer: querySnapshot['answer_index'],
        options: options);
  }
}
