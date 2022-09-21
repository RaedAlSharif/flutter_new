import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_new/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<String> list = <String>['','سيارات   29', 'حريق   34', 'تأمينات هندسية   36', 'تأمينات عامه   35'
  ,'بحري   30','الطبي   1','اجسام طائرات   32','  اجسام سفن   31'];
enum BestTutorSite {daa, javatpoint, w3schools,hh}
class aks extends StatefulWidget {
  const aks({Key? key}) : super(key: key);

  @override
  State<aks> createState() => _aksState();
}

class _aksState extends State<aks> {
  BestTutorSite _site = BestTutorSite.javatpoint;
  static String str = "";
  String str2 = "";
  String errorMassage = "";

  String dropdownValue = list.first;
  final numController = TextEditingController();
  final yearcontroller = TextEditingController();
  final incontroller = TextEditingController();


  DatabaseReference ref = FirebaseDatabase.instance.ref('requests/');
  DatabaseReference ref2 = FirebaseDatabase.instance.ref(cus_department.elementAt(2)+'/');

  @override
  Widget build(BuildContext context) =>

      Container(
        child: Container(
            child:
              Center(
                child: Padding(

                    padding: const EdgeInsets.all(80.70),

                    child: Scaffold(
                      body: Column(
                        children: [
                          Image.asset("lib/img/manara.png"),
                          ListTile(
                          title: const Text('عقد'),
                          leading: Radio(
                            value: BestTutorSite.w3schools,
                            groupValue: _site,
                            onChanged: (BestTutorSite? value) {
                              setState(() {
                                _site = value!;
                                str = "عقد";
                                str2 = "عقد";
                              });
                            },
                          ),
                        ),
                          ListTile(
                            title: const Text('ملحق'),
                            leading: Radio(
                                value: BestTutorSite.daa,
                                groupValue: _site,
                                onChanged: (BestTutorSite? value) {
                                  setState(() {
                                    _site = value!;
                                    str = "ملحق";
                                    str2 = "ملحق";
                                  });
                                }
                            ),
                          ),


                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: numController,
                              decoration: new InputDecoration( border: OutlineInputBorder(),labelText:"رقم " + "ال" + str2),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: incontroller,

                              decoration: new InputDecoration( border: OutlineInputBorder(),labelText: "المؤمن له"),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: yearcontroller,
                              decoration: new InputDecoration( border: OutlineInputBorder(),labelText: "السنة"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        Text("نوع التأمين = " + cus_department.elementAt(2))
                        /*  DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )*/
                          ,


                          TextButton(onPressed: () async {

                            if(str == "" || str2 == ""){
                              errorMassage = "اختيار الزامي عقد او ملحق";
                              return;
                            }

                            if(numController.text.isEmpty){
                              errorMassage = "ادخل رقم الملحق/العقد";
                              return;
                            }
                            if(yearcontroller.text.isEmpty){
                              errorMassage = "ادخل السنه";
                              return;
                            }
                            if(incontroller.text.isEmpty){
                              errorMassage = "ادخل المؤمن له";
                              return;
                            }
                           /* if(MyApp.cus_department == ''){
                              errorMassage = "اختار نوع التأمين";
                              return;
                            }*/


                            ref.child(cus_department.elementAt(0) +" "+  str).child("السنة").set(yearcontroller.text).asStream();
                            ref.child(cus_department.elementAt(0) +" "+  str).child("المؤمن له").set(incontroller.text).asStream();
                            ref.child(cus_department.elementAt(0) +" "+  str).child("رقم الطلب").set(numController.text).asStream();
                            ref.child(cus_department.elementAt(0) +" "+  str).child("نوع التأمين").set(cus_department.elementAt(2)).asStream();

                            ref2.child(cus_department.elementAt(0) +" "+ str).child("السنة").set(yearcontroller.text).asStream();
                            ref2.child(cus_department.elementAt(0) +" "+  str).child("المؤمن له").set(incontroller.text).asStream();
                            ref2.child(cus_department.elementAt(0) +" "+  str).child("رقم الطلب").set(numController.text).asStream();
                            ref2.child(cus_department.elementAt(0) +" "+  str).child("نوع التأمين").set(cus_department.elementAt(2)).asStream();


                            final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
                            final response = await http.post(
                                url,
                                headers: {
                                  'origin': 'http://localhost',
                                  'Content-Type': 'application/json'
                                },
                                body: json.encode(
                                  {
                                    'service_id': 'service_at95yok',
                                    'template_id': 'template_gg5sqzl',
                                    'user_id' : 'Y__n685mzGVQ-WAz2',
                                    'template_params': {
                                      'user_subject':  " طلب عكس قيد "  + str ,

                                      'user_message1':"رقم ال" + str2 + " : " +   numController.text  ,
                                      'user_message2': "\n\nالسنه : " + yearcontroller.text + "\n\n" ,
                                      'user_message3': "\n\nالمؤمن له : " + incontroller.text + "\n\n" ,
                                      'user_message4':  "\n\nنوع التأمين : " + cus_department[2],
                                    }
                                  },
                                )
                            );
                            print(response.body);




                            /* final Email send_email = Email(
    body: "رقم العقد او الملحق : " + numController.text + "\n" +
    "السنه : " + yearcontroller.text + "\n" +
    "المؤمن له : " + incontroller.text + "\n" +
    "نوع التأمين : " + dropdownValue,
    subject: " طلب "  + _site.toString() ,
    recipients: ['219SE2179@isik.edu.tr'],
    isHTML: true,
    );
    await FlutterEmailSender.send(send_email);
*/
                          }, child: Text("Continue")),
                          Text("\n" + errorMassage , style: TextStyle(color: Colors.red),),
                        ],
                      ),
                    )
                ),
              ),
        ),
      );
}