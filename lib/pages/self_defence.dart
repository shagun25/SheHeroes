import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Ho extends StatefulWidget {
  @override
  _HoState createState() => _HoState();
}

class _HoState extends State<Ho> {
  YoutubePlayerController _controller;
  final List<YoutubePlayerController> _controllers = [];
  List<String> urls = [
    'https://youtu.be/tD9JPEq0lJ0',
    'https://youtu.be/T7aNSRoDCmg',
    'https://youtu.be/VIu9sCogmrs',
    'https://youtu.be/bR476k1hPNk',
    'https://youtu.be/Gx3_x6RH1J4',
    'https://youtu.be/bLB85VwjkY0',
    'https://youtu.be/kPdnSPjuucE',
    'https://youtu.be/Ww1DeUSC94o'
  ];
  @override
  void initState() {
    urls.forEach((url) {
      _controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(url));
      _controllers.add(_controller);
    });

    super.initState();
  }

  Widget buildController(int no) {
    return YoutubePlayer(
      controller: _controllers[no],
      showVideoProgressIndicator: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youtube Player'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildController(0),
              SizedBox(height: 10.0),
              buildController(1),
              SizedBox(height: 10.0),
              buildController(2),
              SizedBox(height: 10.0),
              buildController(3),
              SizedBox(height: 10.0),
              buildController(4),
              SizedBox(height: 10.0),
              buildController(5),
              SizedBox(height: 10.0),
              buildController(6),
              SizedBox(height: 10.0),
              buildController(7),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
