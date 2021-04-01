import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safety/providers/profile_provider.dart';

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return SafeArea(
      child: AnimatedContainer(
          height: profileProvider.isProfileOpened == true
              ? MediaQuery.of(context).size.height * (2 / 5)
              : 0,
          width: profileProvider.isProfileOpened == true
              ? MediaQuery.of(context).size.width * (4 / 5)
              : 0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1),
          ),
          duration: Duration(milliseconds: 390),
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 400)),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState
                        .done) if (profileProvider.isProfileOpened == true) {
                  return LayoutBuilder(builder: (context, constraints) {
                    return Container(
                        width: double.infinity,
                        height: constraints.biggest.height,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.deepOrangeAccent, Colors.red])),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                child: Icon(Icons.person),
                                // radius: 50.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Aberle Abner",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                clipBehavior: Clip.antiAlias,
                                color: Colors.white,
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 12.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Height",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              "177 cm",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.pinkAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Weight",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              "28.5 kg",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.pinkAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Blood Group",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              "B+",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.pinkAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                clipBehavior: Clip.antiAlias,
                                color: Colors.white,
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 12.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "City",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              "Ghaziabad",
                                              style: TextStyle(
                                                fontSize: 17.5,
                                                color: Colors.pinkAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Phone",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              "91\n1234567890",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.pinkAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Age",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              "12 y",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.pinkAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
                  });
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Center(
                                child: Column(
                                  // mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Jason Smith',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 25),
                                    ),
                                    Text(
                                      'Age: 17 years',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Height: ',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                      children: [
                                        TextSpan(
                                          text: '177 cm',
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Blood Group: ',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                      children: [
                                        TextSpan(
                                          text: 'B+',
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                child: CircleAvatar(
                                  radius: MediaQuery.of(context).size.width / 8,
                                  child: Icon(
                                    Icons.person,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Weight: ',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                      children: [
                                        TextSpan(
                                          text: '67 kg',
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: 'City: ',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20),
                                      children: [
                                        TextSpan(
                                          text: 'Ghaziabad',
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return SizedBox();
                }
                else {
                  return SizedBox();
                }
              })),
    );
  }
}

class BorderedContainer extends StatelessWidget {
  final child;
  BorderedContainer({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: child,
    );
  }
}
