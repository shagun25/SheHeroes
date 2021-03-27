import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wakelock/wakelock.dart';

import 'fake_incoming_call_screen.dart';

class InstructionScreen extends StatefulWidget {
  static final String route = '/fakeCallSupport';

  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _activateBtnStatus;

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
    _activateBtnStatus = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    wakelockToggling();
    super.dispose();
  }

  Future<void> wakelockToggling() async {
    if (await Wakelock.enabled) Wakelock.disable();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage("assets/mapImage.jpg"),
                  fit: BoxFit.cover),
            ),
            child: ListView(
              shrinkWrap: true,
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
                    left: 20.0,
                    right: 20.0,
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
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20.0),
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      "Activate",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                    onPressed: _activateBtnStatus ? readyForCall : null,
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

  void readyForCall() {
    if (_fakeName.text.length > 0) {
      setState(() {
        _activateBtnStatus = false;
      });
      Wakelock.enable();

      if (this.selectedValue > 0) {
        ScaffoldMessenger.of(_scaffoldKey.currentContext).showSnackBar(SnackBar(
            duration: Duration(seconds: 10),
            content: Text(
                "Wait for ${textValues[selectedValue]} ... Don't switch to other screen")));
      }
      Future.delayed(Duration(minutes: this.selectedValue), () {
        Navigator.pop(_scaffoldKey.currentContext);
        Navigator.pushNamed(context, FakeCallScreen.route,
            arguments: this._fakeName.text);
      });

      Wakelock.disable();
    } else {
      showDialog<String>(
          context: _scaffoldKey.currentContext,
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
  }
}
