import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'fake_incoming_call_screen.dart';

class InstructionScreen extends StatefulWidget {
  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  static const values = <int>[0, 1, 2, 3];
  static const textValues = <String>["Now", "1 min", "3 min", "5 min"];
  int selectedValue = values.first;

  final selectedColor = Colors.green;
  final unselectedColor = Colors.white;

  TextEditingController _fakeName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fakeName = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.phone_callback_rounded,
            size: 30.0,
          ),
          backgroundColor: Color.fromRGBO(0, 230, 0, 1),
          onPressed: () {
            if (_fakeName.text.length > 0) {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FakeCallScreen(
                            fakeCallerName: _fakeName.text,
                          )));
            } else {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        backgroundColor: Colors.black54,
                        title: Text(
                          "Fake caller Name Empty",
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Text(
                          "Enter a Fake Caller Name",
                          style: TextStyle(color: Colors.white),
                        ),
                      ));
            }
          },
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage("assets/mapImage.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.keyboard_arrow_left,
                          size: 40.0,
                          color: Colors.amber,
                        ),
                        Text(
                          "Back",
                          style: TextStyle(fontSize: 25.0, color: Colors.amber),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15.0, top: 10.0),
                  child: Text(
                    "Fake Call",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 10.0,
                      top: 20.0,
                    ),
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text:
                                  'Call yourself using a fake name to get out ',
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 20.0)),
                          TextSpan(
                              text:
                                  'of unpleasant situations. Enter a fake name ',
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 20.0)),
                          TextSpan(
                              text:
                                  'here and select the time until fake call. ',
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 20.0)),
                        ]))),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white70,
                  ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                    controller: _fakeName,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Fake Caller Name",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 50.0,
                    right: 50.0,
                    top: 20.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: buildRadios(context),
                      )
                    ],
                  ),
                ),
              ],
            )),
      );

  Widget buildRadios(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: unselectedColor,
        ),
        child: Row(
          children: values.map(
            (value) {
              return Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Radio<int>(
                        value: value,
                        groupValue: selectedValue,
                        activeColor: selectedColor,
                        onChanged: (value) =>
                            setState(() => this.selectedValue = value),
                      ),
                    ),
                    Expanded(
                      child: Text(textValues[value],
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ),
      );
}
