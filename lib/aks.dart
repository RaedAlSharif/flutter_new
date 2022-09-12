import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

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
    });
    }
    ),
    ),


    Center(
    child: TextFormField(
    controller: numController,
    decoration: new InputDecoration(labelText: "رقم العقد/الملحق"),
    keyboardType: TextInputType.number,
    inputFormatters: <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly
    ],
    ),
    ),
    Center(
    child: TextFormField(
    controller: incontroller,
    decoration: new InputDecoration(labelText: "المؤمن له"),
    ),
    ),

    Center(
    child: TextFormField(
    controller: yearcontroller,
    decoration: new InputDecoration(labelText: "السنة"),
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
    final Email send_email = Email(
    body: "رقم العقد او الملحق : " + numController.text + "\n" +
    "السنه : " + yearcontroller.text + "\n" +
    "المؤمن له : " + incontroller.text + "\n" +
    "نوع التأمين : " + dropdownValue,
    subject: " طلب "  + _site.toString() ,
    recipients: ['219SE2179@isik.edu.tr'],
    isHTML: true,
    );

    await FlutterEmailSender.send(send_email);

    }, child: Text("Continue"))
    ],


    ),

    ),
    );


}
