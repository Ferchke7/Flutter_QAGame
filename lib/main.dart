import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: MyAppExtension());
  }
}

class MyAppExtension extends StatefulWidget {
  const MyAppExtension({super.key});

  @override
  State<MyAppExtension> createState() => _MyAppExtensionState();
}

class _MyAppExtensionState extends State<MyAppExtension> {
  String buttomName = ':)';
  int currentIndex = 0;
  int myRecord = 0;
  bool _isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Answer and Question game'),
      ),
      body: Center(
        child: currentIndex == 0
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Color.fromARGB(255, 221, 213, 212),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.orange),
                      onPressed: () {
                        setState(() {
                          buttomName = '(:';
                        });
                      },
                      child: Text(buttomName),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext buildContext) =>
                                const QuestionPage(),
                          ),
                        );
                      },
                      child: const Text('Start a game'),
                    ),
                  ],
                ),
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    _isClicked = !_isClicked;
                  });
                },
                child: _isClicked
                    ? Image.asset('images/IMGS.png')
                    : Image.network(
                        "https://blog.kakaocdn.net/dn/0mySg/btqCUccOGVk/nQ68nZiNKoIEGNJkooELF1/img.jpg"),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Game', icon: Icon(Icons.gamepad))
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}


class NextPage extends StatelessWidget {
  const NextPage({super.key});   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}


class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late List<Map<String, dynamic>> questions;
  late Map<String, dynamic> currentQuestion = {};
  late String selectedAnswer = "";
  bool isAnswered = false;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    var data = await rootBundle.loadString("images/questions/questions.json");
    setState(() {
      questions = List<Map<String, dynamic>>.from(jsonDecode(data));
      // Select a random question initially
      selectRandomQuestion();
    });
  }

  void selectRandomQuestion() {
  setState(() {
    final random = Random();
    currentQuestion = questions[random.nextInt(questions.length)];
    isAnswered = false;
    selectedAnswer = "";
  });
}

  void checkAnswer() {
    setState(() {
      isAnswered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentQuestion['question'] ?? '',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            if (!isAnswered)
              Column(

                children: [
                  RadioListTile(
                    title: Text(currentQuestion['A'] ?? ''),
                    value: 'A',
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(currentQuestion['B'] ?? ''),
                    value: 'B',
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(currentQuestion['C'] ?? ''),
                    value: 'C',
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(currentQuestion['D'] ?? ''),
                    value: 'D',
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value.toString();
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      checkAnswer();
                    },
                    child: Text("Submit Answer"),
                  ),
                ],
              )
            else
              Text(
                selectedAnswer == currentQuestion['answer']
                    ? 'Correct!'
                    : 'Wrong! The correct answer is ${currentQuestion['answer']}.',
                style: TextStyle(
                  color: selectedAnswer == currentQuestion['answer']
                      ? Colors.green
                      : Colors.red,
                  fontSize: 18,
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                selectRandomQuestion();
              },
              child: Text("Next Question"),
            ),
          ],
        ),
      ),
    );
  }
}