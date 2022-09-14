import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_new/aks.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyBC1RYZ27wlrXy7Ab-S55KFolJYNLvuMJY",
      appId: "1:934507678050:android:45078bf9bad88f6aedc43b",
      projectId: "al-manara-flutt",
      databaseURL: "https://al-manara-flutt-default-rtdb.firebaseio.com/",
      messagingSenderId: '934507678050')
  );

  runApp(const MyApp2());
}
class CustomData extends StatefulWidget {
  const CustomData({Key? key}) : super(key: key);

  @override
  _CustomDataState createState() => _CustomDataState();
}

class _CustomDataState extends State<CustomData> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.blue.shade800,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 640,
            width: 1080,
            margin: EdgeInsets.symmetric(horizontal: 24),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
            ),
            child: Row(
              children: [
                LoginPageLeftSide(),
                if (MediaQuery.of(context).size.width > 900)
                  const LoginPageRightSide(),
              ],

            ),
          ),
        ),
      ),
    );

  }
}
class MyApp2 extends StatelessWidget{
  const MyApp2({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //use MaterialApp() widget like this
        home: MyApp() //create new widget class for this 'home' to
      // escape 'No MediaQuery widget found' error
    );
  }
}
class MyApp extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        children: [

          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => aks()));
              },
              child: Text("عكس قيد / طلب ملحق"),
            ),
          ),

          Text("\n"
              "\n"),

          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustomData()));
              },
              child: Text("طابعة"),
            ),
          ),

          Text("\n"
              "\n"),

          Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CustomData()));
                },
                child: Text("كمبيوتر"),
              ),
          )

        ],
      ),
    );
  }

}
class LoginPageLeftSide extends StatelessWidget {
  final userController = TextEditingController();
  final passController = TextEditingController();

   LoginPageLeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(120.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),),
                const SizedBox(height: 12,),
                 TextField(
                  decoration: InputDecoration(
                      label: Text("email"),
                      hintText: "Please write your email address"
                  ),
                  controller: userController,
                ),
                 TextField(
                   controller: passController,
                  decoration: InputDecoration(
                      label: Text("password"),
                      hintText: "Please write your password"
                  ),
                ),
                const SizedBox(height: 24),



                MaterialButton(onPressed: (){
                  DatabaseReference starCountRef =
                  FirebaseDatabase.instance.ref('users/'+ userController.text +'/username');
                  starCountRef.onValue.listen((DatabaseEvent event) {
                    final username = event.snapshot.value;


                    if (username == userController.text) {
                      if (userController.text == "admin"){
                        DatabaseReference starCountRef2 =
                        FirebaseDatabase.instance.ref('users/' +
                            userController.text + '/password');
                        starCountRef2.onValue.listen((DatabaseEvent event) {
                          final password = event.snapshot.value;

                          if (password == passController.text) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => adminPage()));

                          }
                        });
                      }
if (userController.text != "admin"){
  DatabaseReference starCountRef2 =
  FirebaseDatabase.instance.ref('users/' +
      userController.text + '/password');
  starCountRef2.onValue.listen((DatabaseEvent event) {
    final password = event.snapshot.value;

    if (password == passController.text) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => aks()));
    }
    else {

    }
  });
}

                    }
                    else{

                    }
                  });
                },child: Text("Login"),
                  minWidth: double.infinity,
                  height: 52,
                  elevation: 24,
                  color: Colors.blue.shade800,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
class LoginPageRightSide extends StatelessWidget {
  const LoginPageRightSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          color: Colors.orange,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/img/manara.png'),
                  fit: BoxFit.fill),
            ),
          ),
        ));
  }
}


class adminPage extends StatefulWidget {
  const adminPage({Key? key}) : super(key: key);

  @override
  State<adminPage> createState() => _adminPageState();
}

class _adminPageState extends State<adminPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(

        body: Column(
          children: [
            TextButton(onPressed: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => aks()));
            }, child: Text("Create new User")),
            TextButton(onPressed: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => aks()));
            }, child: Text("View all users"))
          ],
        )
      ),

    );
  }
}
