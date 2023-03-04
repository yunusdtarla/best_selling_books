import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:web_scrapingg/kitap.dart';
import 'bottom_bar.dart';
import 'page/kitap_yurdu_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      color: Color.fromARGB(255, 75, 61, 10),
      home: BottomBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
