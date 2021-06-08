import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'bmi_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// import 'dataAssisten.dart';
// import 'dataadmin.dart';


SharedPreferences logindata;
bool newuser;
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}
class _MyLoginPageState extends State<MyLoginPage> {

  // of the TextField.
  final String url = 'http://127.0.0.1:8000/api/dataadmin/';

  Future getAdmin() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  // SharedPreferences logindata;
  // bool newuser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MyDashboard()));
    }
  }
  @override
  void dispose() {

    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Shared Preferences"),
      ),
      body:
      // new ListView.builder(
      //     shrinkWrap: true,
      //     itemBuilder: (BuildContext context, int index) {
      //       data = new MyData.fromJson(dataAssisten[index]);
      //      return new Text("${dataAssisten[index]["UserName"]} ${dataAssisten[index]["PassWord"]}");
      //
      //     })

      Center(
        child:
      FutureBuilder (
    future: getAdmin(),
    builder: (context, snapshot) {
    if (snapshot.hasData) {

    return

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

        ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {

              return ;
            }),
            Text(
              "Login Form " ,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            // Text(
            //   "To show Example of Shared Preferences",
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: password_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(

              onPressed: () {

                for (int i = 0; i<snapshot.data.length;i++) {
                  String username = username_controller.text;
                  String password = password_controller.text;

                  if (username == snapshot.data['data'][i]['username'] &&
                      password == snapshot.data['data'][i]['password']) {
                    print('Successfull');
                    String nama =  snapshot.data['data'][i]['nama'];
                    logindata.setBool('login', false);
                    logindata.setString('username', username);
                    logindata.setString('fullname', nama);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyDashboard()));
                   }
    // else {
                  //  print('salah');
                  //
                  // }
                }
              },
              child: Text("Log-In"),
            )
          ],

        );
      } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
      }
      // By default show a loading spinner.
      return CircularProgressIndicator();
    },
      ),
      ),
    );
  }
}