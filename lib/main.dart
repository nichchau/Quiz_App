import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizapp/questionbank.dart';
import './quiz.dart';
import './result.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = QuestionBank.questions;

  var _questionIndex = 0;
  var _totalScore = 0;
  List _currentQuestion = [];
  List questionNum=[];
  int i=0;
  int _start =20;
  Timer? _timer ;

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _start = 20;
     _timer =  new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            _timer!.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  @override
  void initState() {
    super.initState();
    while (i<_questions.length){
      questionNum.add(i);
      i++;
    }
    _shuffleQuestions();
    _startTimer();
  }
  void restartTimer() {
    _timer!.cancel();
    _startTimer();
  }
  //@override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }


  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _currentQuestion = [];
      i=0;
      while (i<_questions.length){
        questionNum.add(i);
        i++;
      }
      _shuffleQuestions();
    });
  }

  void _shuffleQuestions() {
    if (_currentQuestion.length!=_questions.length) {
      questionNum.shuffle();
      _currentQuestion.add(questionNum[0]);
      setState(() {
        _questionIndex = questionNum[0];
      });
      questionNum.remove(questionNum[0]);
      _startTimer();
    }else{
      setState(() {
        _questionIndex = _questions.length+1;
      });
    }
  }

  void _answerQuestion(int score) {
    _shuffleQuestions();
    _totalScore += score;
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Quiz Demo'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
            padding: const EdgeInsets.all(30.0),
            child:Column(
                children:<Widget>[
                  Text('Seconds left: $_start'),
                  _questionIndex < _questions.length &&_start>0
                      ?
                  Quiz(
                    answerQuestion: _answerQuestion,
                    questionIndex: _questionIndex,
                    questions: _questions,
                  )//Quiz
                      : Result(_totalScore, _resetQuiz),
                ])
        ), //Padding
      ), //Scaffold
      debugShowCheckedModeBanner: false,
    ); //MaterialApp
  }
}


