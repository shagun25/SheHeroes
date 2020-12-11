// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';

// // import 'package:here_sdk/core.dart';
// // import 'package:here_sdk/mapview.dart';
// // import 'package:location/location.dart';
// // class HereMap extends StatefulWidget {
// //   @override
// //   _HereMapState createState() => _HereMapState();
  
// // }

// // class _HereMapState extends State<HereMap> {
// //   @override
// //   void initState(){
// //     SdkContext.init(IsolateOrigin.main);
    
// //   }
 
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child:HereMap(onMapCreated: _onMapCreated)
// //     );
// //   }
// //    void _onMapCreated(HereMapController hereMapController) {
// //        hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
// //         (MapError error) {
// //       if (error != null) {
// //         print('Map scene not loaded. MapError: ${error.toString()}');
// //         return;
// //       }
// //       const double distanceToEarthInMeters = 8000;
// //       hereMapController.camera.lookAtPointWithDistance(
// //           GeoCoordinates(50, 50), distanceToEarthInMeters);
// // },};
// // }


// /*
//  * Copyright (C) 2019-2020 HERE Europe B.V.
//  *
//  * Licensed under the Apache License, Version 2.0 (the "License");
//  * you may not use this file except in compliance with the License.
//  * You may obtain a copy of the License at
//  *
//  *     http://www.apache.org/licenses/LICENSE-2.0
//  *
//  * Unless required by applicable law or agreed to in writing, software
//  * distributed under the License is distributed on an "AS IS" BASIS,
//  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  * See the License for the specific language governing permissions and
//  * limitations under the License.
//  *
//  * SPDX-License-Identifier: Apache-2.0
//  * License-Filename: LICENSE
//  */

// import 'package:flutter/material.dart';
// import 'package:here_sdk/core.dart';
// import 'package:here_sdk/mapview.dart';

// void main() {
//   SdkContext.init(IsolateOrigin.main);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'HERE SDK for Flutter - Hello Map!',
//       home: HereMap(onMapCreated: _onMapCreated),
//     );
//   }

//   void _onMapCreated(HereMapController hereMapController) {
//     hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
//         (MapError error) {
//       if (error != null) {
//         print('Map scene not loaded. MapError: ${error.toString()}');
//         return;
//       }

//       const double distanceToEarthInMeters = 8000;
//       hereMapController.camera.lookAtPointWithDistance(
//           GeoCoordinates(52.530932, 13.384915), distanceToEarthInMeters);
//     });
//   }
// }
// class HereMap extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }