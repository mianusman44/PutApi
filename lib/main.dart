import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<UserModel> updateUser(int id, String name, String jobTitle) async {
  final String apiUrl = "https://reqres.in/api/users/$id";

  final response =
      await http.put(apiUrl, body: {"name": name, "job": jobTitle});

  if (response.statusCode == 200) {
    final String responseString = response.body;

    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  UserModel _user;

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            TextField(
              controller: idController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter Id'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter Username'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: jobController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Job title'),
            ),
            SizedBox(
              height: 32,
            ),
            _user == null
                ? Container()
                : Text(
                    "The user ${_user.name},Job title ${_user.job} is updatted successfully at time ${_user.updatedAt.toIso8601String()}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String id = idController.text;
          final String name = nameController.text;
          final String jobTitle = jobController.text;

          final UserModel user =
              await updateUser(int.parse(id), name, jobTitle);

          setState(() {
            _user = user;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
