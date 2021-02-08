import 'package:flutter/material.dart';
import 'costanti.dart';

class FourthScreen extends StatefulWidget {
  FourthScreen({
    Key key, //this.title
  }) : super(key: key);

  @override
  _FourthScreenState createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  void _goBack() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Do less, take more',
      //     style: TextStyle(
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.black],
          ),
        ),
        child: Center(
          child: ListView(children: [
            Text(//dati2 != null ? dati2.toString() : errore
                voti.toString()),
            //Text("voti".toString())
          ]),
        ),
      ),
    );
  }
}
