import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController scoreController = TextEditingController();

  int exportCount = 0; // 사용자가 Export를 누른 횟수를 추적하는 변수

  _exportToServer() async {
    var score = scoreController.text;
    var url = Uri.parse('http://localhost:5000/upload'); // Flask 서버의 엔드포인트 URL

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'score': score,
      }),
    );

    if (response.statusCode == 200) {
      // 성공적으로 데이터를 전송했을 때의 처리
      print('Data uploaded successfully');
    } else {
      // 서버로부터 오류 응답을 받았을 때의 처리
      print('Failed to upload data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export to Excel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: scoreController,
              decoration: const InputDecoration(hintText: 'Enter score'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _exportToServer, // 함수를 _exportToServer로 변경
              child: const Text('Export'),
            ),
          ],
        ),
      ),
    );
  }
}
