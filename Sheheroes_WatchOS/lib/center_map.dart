// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:safety/pages/emergency_map.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
//   GoogleMapController _controller;
//   Location _location = Location();

//   MapType _defaultMapType = MapType.normal;

//   void _onMapCreated(GoogleMapController _cntlr) {
//     _controller = _cntlr;
//     _location.onLocationChanged.listen((l) {
//       _controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: LatLng(l.latitude, l.longitude),
//             zoom: 15,
//           ),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(115),
//             child: GoogleMap(
//               initialCameraPosition:
//                   CameraPosition(target: _initialcameraposition),
//               trafficEnabled: true,
//               onMapCreated: _onMapCreated,
//               myLocationButtonEnabled: false,
//               mapToolbarEnabled: false,
//               myLocationEnabled: true,
//               mapType: _defaultMapType,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//---------------------------------API-----------------------------------------

double lat;
double lon;

class CityData {
  int totalIncidents;
  int totalPages;
  List<Incidents> incidents;

  CityData({this.totalIncidents, this.totalPages, this.incidents});

  CityData.fromJson(Map<String, dynamic> json) {
    totalIncidents = json['total_incidents'];
    totalPages = json['total_pages'];
    if (json['incidents'] != null) {
      incidents =  <Incidents>[];
      json['incidents'].forEach((v) {
        incidents.add(Incidents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // ignore: unnecessary_this
    data['total_incidents'] = this.totalIncidents;
    data['total_pages'] = totalPages;
    if (incidents != null) {
      data['incidents'] = incidents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Incidents {
  String incidentCode;
  String incidentDate;
  String incidentOffense;
  String incidentOffenseCode;
  String incidentOffenseDescription;
  String incidentOffenseDetailDescription;
  String incidentOffenseCrimeAgainst;
  String incidentOffenseAction;
  String incidentSourceName;
  double incidentLatitude;
  double incidentLongitude;

  Incidents(
      {this.incidentCode,
      this.incidentDate,
      this.incidentOffense,
      this.incidentOffenseCode,
      this.incidentOffenseDescription,
      this.incidentOffenseDetailDescription,
      this.incidentOffenseCrimeAgainst,
      this.incidentOffenseAction,
      this.incidentSourceName,
      this.incidentLatitude,
      this.incidentLongitude});

  Incidents.fromJson(Map<String, dynamic> json) {
    incidentCode = json['incident_code'];
    incidentDate = json['incident_date'];
    incidentOffense = json['incident_offense'];
    incidentOffenseCode = json['incident_offense_code'];
    incidentOffenseDescription = json['incident_offense_description'];
    incidentOffenseDetailDescription =
        json['incident_offense_detail_description'];
    incidentOffenseCrimeAgainst = json['incident_offense_crime_against'];
    incidentOffenseAction = json['incident_offense_action'];
    incidentSourceName = json['incident_source_name'];
    incidentLatitude = json['incident_latitude'];
    incidentLongitude = json['incident_longitude'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final data = Map<String, dynamic>();
    data['incident_code'] = incidentCode;
    data['incident_date'] = incidentDate;
    data['incident_offense'] = incidentOffense;
    // ignore: unnecessary_this
    data['incident_offense_code'] = this.incidentOffenseCode;
    data['incident_offense_description'] = incidentOffenseDescription;
    data['incident_offense_detail_description'] =
        incidentOffenseDetailDescription;
    data['incident_offense_crime_against'] = incidentOffenseCrimeAgainst;
    data['incident_offense_action'] = incidentOffenseAction;
    data['incident_source_name'] = incidentSourceName;
    data['incident_latitude'] = incidentLatitude;
    data['incident_longitude'] = incidentLongitude;
    return data;
  }
}

//-------------------GoogleMap Widget----------------------------------------

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      'https://private-anon-c41e4e8ae7-crimeometer.apiary-mock.com/v1/incidents/crowdsourced-raw-data?lat=lat&lon=lon&distance=distance&datetime_ini=datetime_ini&datetime_end=datetime_end&page=page';
  var data;

  @override
  void initState() {
    super.initState();
    // getData();
  }

  Iterable markers = [];
  CityData cd;
  Future getData() async {
    log('data recieved');
    var res = await http.get(url);
    //log(res.statusCode.toString());
    //cd = CityData.fromJson();
    //log(res.body.toString());
    data = jsonDecode(res.body);
    //data = json.decode(res.body).cast<Map<String, dynamic>>();
    log(data.toString());
    print(
        '\nhello: ' + data[0]['incidents'][0]['incident_longitude'].toString());
    // ignore: omit_local_variable_types
    return data;
  }

  final LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  final Location _location = Location();

  final MapType _defaultMapType = MapType.normal;

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      setState(() {
        lat = l.latitude;
        lon = l.longitude;
      });
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(l.latitude, l.longitude),
            zoom: 15,
          ),
        ),
      );
    });
  }

  // Map<MarkerId, Marker> markers =
  //     <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  // void _add(index) {
  //   //var markerIdVal = MyWayToGenerateId();
  //   final MarkerId markerId = MarkerId('M1');

  //   // creating a new MARKER
  //   final Marker marker = Marker(
  //       markerId: markerId,
  //       position: LatLng(lat, lon),
  //       icon: BitmapDescriptor.defaultMarkerWithHue(5.2)
  //       //infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
  //       // onTap: () {
  //       //   _onMarkerTapped(markerId);
  //       // },
  //       );

  //   setState(() {
  //     // adding a new marker to map
  //     markers[markerId] = marker;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints.expand(),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(115),
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialcameraposition),
                  trafficEnabled: true,
                  onMapCreated: _onMapCreated,
                  myLocationButtonEnabled: false,
                  mapToolbarEnabled: false,
                  myLocationEnabled: true,
                  mapType: _defaultMapType,
                  zoomControlsEnabled: false,
                  markers: Set.from(
                    markers,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
