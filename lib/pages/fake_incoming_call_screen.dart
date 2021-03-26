import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FakeCallScreen extends StatelessWidget {
  String fakeCallerName;

  FakeCallScreen({@required this.fakeCallerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 1,
            backgroundColor: Colors.redAccent,
            child: Icon(
              Icons.call_end_rounded,
            ),
            onPressed: () {},
          ),
          FloatingActionButton(
            heroTag: 2,
            backgroundColor: Color.fromRGBO(0, 250, 0, 0.9),
            child: Icon(
              Icons.phone,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/fakeCallBG.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.person,
                size: 50.0,
                color: const Color.fromRGBO(253, 200, 4, 1.0),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                this.fakeCallerName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
