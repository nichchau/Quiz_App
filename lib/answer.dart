import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback  selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:const EdgeInsets.all(3.0),
      child: ElevatedButton(
        child: Text(answerText),
        onPressed: selectHandler,
      ), //RaisedButton
    ); //Container
  }
}
