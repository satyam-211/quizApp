import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class AnswerCard extends StatefulWidget {
  final void Function(bool correct) submit;

  final int correctIndex;

  final List<String> options;

  const AnswerCard({Key key, this.submit, this.correctIndex, this.options})
      : super(key: key);

  @override
  _AnswerCardState createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {
  bool answerSelected = false;
  @override
  Widget build(BuildContext context) {
    selectAnswer(bool isCorrect) {
      setState(() {
        answerSelected = true;
      });
      Timer(Duration(seconds: 1), () {
        answerSelected = false;
        widget.submit(isCorrect);
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.options
          .map((option) => Flexible(
                child: Card(
                  color: upperPartColor,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: answerSelected
                            ? Border.all(
                                color: option ==
                                        widget.options[widget.correctIndex]
                                    ? Colors.indigo
                                    : Colors.red,
                                width: 3)
                            : null),
                    child: AnswerBar(
                        optionText: option,
                        isCorrect:
                            option == widget.options[widget.correctIndex],
                        answerSelected: answerSelected,
                        selectAnswer: selectAnswer),
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class AnswerBar extends StatelessWidget {
  final String optionText;
  final bool isCorrect;
  final bool answerSelected;
  final Function(bool isCorrect) selectAnswer;

  const AnswerBar(
      {Key key,
      this.optionText,
      this.isCorrect,
      this.answerSelected,
      this.selectAnswer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerSelected
          ? null
          : () {
              selectAnswer(isCorrect);
            },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$optionText',
            style: Theme.of(context).primaryTextTheme.headline6,
          ),
          if (answerSelected && isCorrect)
            Icon(
              Icons.check_circle,
              color: Colors.indigo,
            )
        ],
      ),
    );
  }
}
