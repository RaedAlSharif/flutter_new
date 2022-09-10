import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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


    final userController = TextEditingController();
    final passController = TextEditingController();







    return Scaffold(
      appBar: AppBar(title: Text("Hi"),),
      body: SingleChildScrollView(
        child: Column(

          children: [
            Text("Device Width ${MediaQuery.of(context).size.width}"),
            Text("Device Height ${MediaQuery.of(context).size.height}"),

            TextField(
              controller: userController,
              textAlign: TextAlign.center,
              decoration: InputDecoration( labelText: "Username"),
            ),

            TextField(
              controller: passController,
              textAlign: TextAlign.center,
              decoration: InputDecoration( labelText: "password"),
            ),
            Center(
              child: TextButton(

                onPressed: () {
                  DatabaseReference starCountRef =
                  FirebaseDatabase.instance.ref('users/'+ userController.text +'/username');
                  starCountRef.onValue.listen((DatabaseEvent event) {
                    final username = event.snapshot.value;


                    if (username == userController.text) {
                      DatabaseReference starCountRef2 =
                      FirebaseDatabase.instance.ref('users/' +
                          userController.text + '/password');
                      starCountRef2.onValue.listen((DatabaseEvent event) {
                        final password = event.snapshot.value;

                        if (password == passController.text) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        }
                        else {
                          
                        }
                      });
                    }
                    else{

                    }
                  });
                }, child: Text("Continue"),

              ),
            )
          ],
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
          Text("Device Width ${MediaQuery.of(context).size.width}"),
          Text("Device Height ${MediaQuery.of(context).size.height}"),

          Text("Welcomee bitch"),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              emailController.text = "2323";
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CustomData()));
            },
            child: Text("Sign in"),
          )
        ],
      ),
    );
  }

}
