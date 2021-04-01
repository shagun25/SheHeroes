import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safety/providers/profile_provider.dart';

class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double margin;
  final Widget child;
  RoundedAppBar({this.margin, this.child});
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Stack(
      children: [
        GestureDetector(
          onTap: () => profileProvider.closeProfile(),
          child: SizedBox.fromSize(
            size: preferredSize,
            child: LayoutBuilder(builder: (context, constraint) {
              final width = constraint.maxWidth * 17;
              return ClipRect(
                child: OverflowBox(
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  child: SizedBox(
                    width: width,
                    height: width,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: width / 2 - preferredSize.height / 2),
                      child: Container(
                        // elevation: 2,
                        // shadowColor: Colors.black45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  // spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black38)
                            ]),
                        margin: EdgeInsets.only(bottom: margin),
                        child: child,
                        // shape: CircleBorder(),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        Positioned(
          right: 0,
          top: 5,
          child: SafeArea(
            // ignore: deprecated_member_use
            child: FlatButton(
              splashColor: Colors.transparent,
              // hoverColor: Colors.transparent,
              // highlightColor: Colors.transparent,
              // focusColor: Colors.transparent,
              onPressed: () {
                profileProvider.isProfileOpened == true
                    ? profileProvider.closeProfile()
                    : profileProvider.openProfile();
              },
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Text(
                    'Aberle Abner',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xffffc400),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 5,
          child: SafeArea(
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}
// SafeArea(
//           child: ExpansionTile(
//             title: null,
//             trailing: Opacity(
//               opacity: 0,
//             ),
//             onExpansionChanged: (value) {
//               print(value);
//               value == false
//                   ? profileProvider.closeProfile()
//                   : profileProvider.openProfile();
//             },
//             children: [
//               Container(
//                 margin: EdgeInsets.only(bottom: 2),
//                 decoration: BoxDecoration(
//                   boxShadow: [BoxShadow(blurRadius: 2)],
//                   color: Colors.white,
//                 ),
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height / 5,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                       Text('Hi'),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
