import 'package:flutter/material.dart';

class EmergencyPeopleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People in an emergency'),
      ),
      body: Container(
        child: Column(
          children: [
            PersonTileEmergency(),
          ],
        ),
      ),
    );
  }
}

class PersonTileEmergency extends StatelessWidget {
  final name;

  final distance;
  final minutes;
  PersonTileEmergency({
    this.name,
    this.distance,
    this.minutes,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamed('Emergency_Map');
        },
        child: ListTile(
          title: Text(name),
          subtitle: Text('Distance: $distance m   Time to reach: $minutes min'),
          trailing: Icon(Icons.map),
        ),
      ),
    );
  }
}
