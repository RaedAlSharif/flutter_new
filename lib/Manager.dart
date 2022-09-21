import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/main.dart';

class Managers extends StatefulWidget {
  const Managers({Key? key}) : super(key: key);

  @override
  State<Managers> createState() => _ManagersState();
}

class _ManagersState extends State<Managers> {
  DatabaseReference ref = FirebaseDatabase.instance.ref(cus_department.elementAt(2)+'/');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cus_department.elementAt(2)+" Page , WELCOME"),
      ),
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
            child: Center(


              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("جميع طلبات عكس القيود", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
                  const SizedBox(height: 12,),

                  Flexible(

                      child: FirebaseAnimatedList(

                          query: ref, itemBuilder: (BuildContext context,
                          DataSnapshot snapshot ,
                          Animation<double> animaton
                          , int index ) {

                        Map user = snapshot.value as Map;

                        return ListTile(

                          trailing: IconButton(icon: Icon(Icons.edit), onPressed: () =>{

                          }),

                          title: Text( snapshot.key.toString() + "\n\n"
                              + "السنة: "+ user['السنة']  + "\n\n"
                              + "المؤمن له: "+ user['المؤمن له'] + "\n\n"
                              + "رقم العقد/الملحق: "+ user["رقم الطلب" ] + "\n\n"
                              + "نوع التأمين: "+ user['نوع التأمين'] + "\n\n"

                          ),
                        );
                      } ) ),

                ],
              ),


            ),
          ),
        ),
      ),
    );
  }
}
