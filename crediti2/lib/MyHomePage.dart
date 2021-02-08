import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'costanti.dart';
import 'loadingScreen.dart';
import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myControllerU = TextEditingController();
  final myControllerP = TextEditingController();
  final myControllerA = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _login();
      Navigator.pushNamed(context, '/second');
    });
  }

  void _showRatingDialog() async {
    await animated_dialog_box.showInOutDailog(
        title: Center(child: Text("Ops")), // IF YOU WANT TO ADD
        context: context,
        firstButton: Center(
          widthFactor: 50.0,
          child: MaterialButton(
            // FIRST BUTTON IS REQUIRED
            elevation: 900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            color: Colors.orange,
            child: Text('Login'),
            onPressed: () {
              Navigator.pushNamed(context, '/homeq');
            },
          ),
        ),
        /*secondButton: MaterialButton(
          // OPTIONAL BUTTON
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: Colors.white,
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),*/
        icon: Icon(
          Icons.info_outline,
          color: Colors.red,
        ), // IF YOU WANT TO ADD ICON
        yourWidget: Container(
          child: Text(
            'Qualcosa è andato storto, ricontrolla le credenziali e riprova',
          ),
        ));
  }

  void _login() async {
    codiceScuola = myControllerA.text;
    username = myControllerU.text;
    password = myControllerP.text;
    Map<String, String> data = {
      'school_code': codiceScuola,
      'username': username,
      'password': password
    };
    const url = 'https://liceoscacchi.herokuapp.com/';
    await http.post(url, body: data).then((response) {
      try {
        //_showaccettazionetermini();
        dati = response.body;
        dati1 = jsonDecode(dati);
        dati2 = dati1[username];
        ottieniMaterie();
        ottieniVoti();
      } catch (e) {
        errore = 'Non è stato possibile accedere ai tuoi dati $e';
        _showRatingDialog();
        print(errore);
      }
    });
  }

  @override
  void dispose() {
    myControllerA.dispose();
    myControllerU.dispose();
    myControllerP.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.black],
          ),
        ),
        child: ListView(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.fromLTRB(50, 46, 50, 38),
                // decoration: BoxDecoration(boxShadow: [
                //   BoxShadow(
                //     color: Colors.blue,
                //     offset: Offset(0.0, 0.0),
                //     blurRadius: 5.0,
                //     spreadRadius: 7.0,
                //   )
                // ], shape: BoxShape.circle),
                child: Image(
                  image: AssetImage('images/logo.jpg'),
                  height: 68,
                )),
            SizedBox(
                child: Column(
              children: <Widget>[
                TextField(
                  controller: myControllerA,
                  style: TextStyle(color: Colors.white60),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    counterText: '',
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1,
                      ),
                    ),
                    hintText: 'Codice Scuola',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  maxLength: 32,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
                TextField(
                  controller: myControllerU,
                  style: TextStyle(color: Colors.white60),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    counterText: '',
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1,
                      ),
                    ),
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  maxLength: 32,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
                TextField(
                  controller: myControllerP,
                  obscureText: true,
                  style: TextStyle(color: Colors.white60),
                  enabled: true,
                  decoration: InputDecoration(
                      counterText: '',
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white)),
                  maxLength: 32,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 120, maxWidth: 230),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsetsDirectional.only(top: 50)),
                      FlatButton(
                        onPressed: _incrementCounter,
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        color: Colors.orange[400],
                        textColor: Colors.black,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.grey,
                        hoverColor: Colors.grey,
                        shape: StadiumBorder(
                            side: BorderSide(color: Colors.teal, width: 2)),
                      ),
                      Padding(
                          padding: const EdgeInsetsDirectional.only(top: 16)),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 42),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
