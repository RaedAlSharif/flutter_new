import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<String> list = <String>['سيارات   29', 'حريق   34', 'تأمينات هندسية   36', 'تأمينات عامه   35'
  ,'بحري   30','الطبي   1','اجسام طائرات   32','  اجسام سفن   31'];
enum BestTutorSite { javatpoint, w3schools}
class aks extends StatefulWidget {
  const aks({Key? key}) : super(key: key);

  @override
  State<aks> createState() => _aksState();
}

class _aksState extends State<aks> {
  BestTutorSite _site = BestTutorSite.javatpoint;
  String str = "";
  String str2 = "";

  String dropdownValue = list.first;
  final numController = TextEditingController();
  final yearcontroller = TextEditingController();
  final incontroller = TextEditingController();


  @override
  Widget build(BuildContext context) =>

      Container(decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/img/manara.png"),
              fit: BoxFit.cover
          )
      ),
        child: Scaffold(



          body: Column(


            children: [

              ListTile(
                title: const Text('عقد'),
                leading: Radio(
                  value: BestTutorSite.javatpoint,
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
                    value: BestTutorSite.w3schools,
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
              DropdownButton<String>(
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
              )
              ,


              TextButton(onPressed: () async {

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
                      'user_message4':  "\n\nنوع التأمين : " + dropdownValue,
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
              }, child: Text("Continue"))
            ],


          ),

        ),
      );


}