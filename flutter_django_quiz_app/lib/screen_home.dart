import 'package:flutter/material.dart';
import 'package:flutter_django_quiz_app/sceen_quiz.dart';
import 'api_adapter.dart';
import 'model_quiz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //퀴즈데이터 호출 API
List<Quiz> quizs = [];
bool isLoading = false;
_fetchQuizs() async{
  setState(() {
    isLoading = true;
  });
  final response = await http.get('http://127.0.0.1:8000/quiz/3/');
  if(response.statusCode==200){
    setState(() {
      quizs = parseQuizs(utf8.decode(response.bodyBytes));
      isLoading = false;

    });
  } else{
    throw Exception('Failed to Load Data');
  }
  print(response);
}

//
//  List<Quiz> quizs = [
//    Quiz.fromMap({
//      'title': 'test',
//      'candidates' : ['a','b','c', 'd',],
//      'answer': 0
//    }),
//    Quiz.fromMap({
//      'title': 'test',
//      'candidates' : ['a','b','c','d',],
//      'answer': 0
//    }),
//    Quiz.fromMap({
//      'title': 'test',
//      'candidates' : ['a','b','c','d', ],
//      'answer': 0
//    }),
//
//  ];


  @override
  Widget build(BuildContext context) {

     Size screenSize = MediaQuery.of(context).size;  // 현재 기기의 사이즈측정
     double width = screenSize.width;
     double heihgt = screenSize.height;





    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("QUIZ APP"),
            backgroundColor: Colors.deepPurple,
            leading: Container(),
          ),
        body: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Image.asset(
                  'images/icon.png', width: width *0.8,
                ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.024),
            ),
            Text(
              "플러터 장고 퀴즈앱",
              style: TextStyle(
              fontSize: width *0.065,
                fontWeight: FontWeight.bold,
            ),
            ),
            Text(
              '퀴즈문항을 꼼꼼히 읽고 답하여주세요.\n',
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.048),
            ),
            _buildStep(width, '1. 본 퀴즈는 정확하게 답하여주세요.'),
            _buildStep(width, '2. 정답을 확인하고 다음 버튼을 눌러주세요.'),
            Padding(
              padding: EdgeInsets.all(width * 0.048),
            ),
            Container(padding:EdgeInsets.only(bottom:width * 0.036),
            child: Center(
              child: ButtonTheme(
                minWidth: width * 0.8,
                height: heihgt * 0.05,
                shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(10),
                ),
                child: RaisedButton(child:  Text(
                    '퀴즈풀기',
                style:  TextStyle(color:Colors.white),
                ),
                  color: Colors.deepPurple,
                  onPressed: () {
                  _fetchQuizs().whenComplete((){
                    return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(
                          quizs: quizs,
                        ),
                      ),
                    );
                  });
                  },
                ),
              ),
            ),)
          ],
        ),

        ),
      ),
    );
  }

  Widget _buildStep (double width, String title){
    return Container(
      padding: EdgeInsets.fromLTRB(
          width * 0.048,
          width * 0.024,
          width * 0.048,
          width * 0.024,
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.check_box,
        size: width *0.04,
        ),
        Padding(padding: EdgeInsets.only(right: width *0.024),
        ),
        Text(title),
      ],),
    );
  }

}
