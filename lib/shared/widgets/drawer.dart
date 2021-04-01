import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:safety/pages/emergency_dashboard.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xffffc400),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://cnet3.cbsistatic.com/img/-qQkzFVyOPEoBRS7K5kKS0GFDvk=/940x0/2020/04/16/7d6d8ed2-e10c-4f91-b2dd-74fae951c6d8/bazaart-edit-app.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
                // backgroundColor: Colors.blue,
              ),
              accountEmail: Text(
                'aberle@abner.com',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17
                    // color: Color(0xffffc400),
                    ),
              ),
              accountName: Text(
                'Aberle Abner',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17
                    // color: Color(0xffffc400),
                    ),
              ),
              // margin: EdgeInsets.zero,
              // padding: EdgeInsets.zero,
              // child: Image(
              //   image: NetworkImage(
              //       'https://cnet3.cbsistatic.com/img/-qQkzFVyOPEoBRS7K5kKS0GFDvk=/940x0/2020/04/16/7d6d8ed2-e10c-4f91-b2dd-74fae951c6d8/bazaart-edit-app.jpg'),
              //   fit: BoxFit.fill,
              // ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: ListTile(
                leading: Text(
                  'Edit Profile',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(244, 102, 66, 1)),
                ),
                trailing: Icon(
                  Icons.person,
                  color: Color(0xffffc400),
                ),
              ),
            ),
            Divider(
              height: 2,
              indent: 15,
              endIndent: 110,
              thickness: 1.2,
              color: Colors.grey,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: ListTile(
                leading: Text(
                  'View Intro Screens',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(244, 102, 66, 1)),
                ),
                trailing: Icon(
                  Icons.help_outline,
                  color: Color(0xffffc400),
                ),
              ),
            ),
            Divider(
              height: 2,
              indent: 15,
              endIndent: 110,
              thickness: 1.2,
              color: Colors.grey,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: ListTile(
                leading: Text(
                  'Contact Us',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(244, 102, 66, 1)),
                ),
                trailing: Icon(
                  Icons.contact_mail,
                  color: Color(0xffffc400),
                ),
              ),
            ),
            Divider(
              height: 2,
              indent: 15,
              endIndent: 110,
              thickness: 1.2,
              color: Colors.grey,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: ListTile(
                leading: Text(
                  'Log Out',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(244, 102, 66, 1)),
                ),
                trailing: Icon(
                  Icons.format_line_spacing,
                  color: Color(0xffffc400),
                ),
              ),
            ),
            Divider(
              height: 2,
              indent: 15,
              endIndent: 110,
              thickness: 1.2,
              color: Colors.grey,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: ListTile(
                leading: Text(
                  'Dark Mode',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(244, 102, 66, 1)),
                ),
                trailing: Transform.scale(
                  alignment: Alignment.centerRight,
                  origin: Offset(26, 0),
                  scale: 0.7,
                  child: CupertinoSwitch(
                    activeColor: Color(0xffffc400),
                    onChanged: (bool value) {},
                    value: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget Drawer_zoom(BuildContext context) {
  return ZoomDrawer(
    // controller: ZoomDrawerController,
    menuScreen: Hom(),
    mainScreen: MyDrawer(),
    borderRadius: 24.0,
    showShadow: true,
    angle: -12.0,
    backgroundColor: Colors.grey[300],
    slideWidth:
        MediaQuery.of(context).size.width * (ZoomDrawer.isRTL() ? .45 : 0.65),
  );
}
