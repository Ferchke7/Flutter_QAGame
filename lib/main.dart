import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String buttomName = 'Click';
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App title'),
        ),
        body: Center(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buttomName = 'Clicked';
                      });
                    },
                    child: Text(buttomName),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buttomName = 'Clicked';
                      });
                    },
                    child: Text(buttomName),
                  ),
                ],
              ),
                      ],
                    ),
            )),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: 'Settings', icon: Icon(Icons.settings))
          ],
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
