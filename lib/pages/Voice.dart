// import 'dart:html';
import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:safety/pages/self_defence.dart';
import 'package:safety/services/calls_and_messages_service.dart';
import 'package:safety/services/service_locator.dart';
import 'package:safety/shared/constants.dart';
import 'package:safety/ui/homescreen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget {
  static final String route = '/speechScreen';

  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  final CallsAndMessagesService service = locator<CallsAndMessagesService>();
  final String number = "123456789";
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
        backgroundColor: Color(0xffb72334),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Color(0xfffcbeac),
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          backgroundColor: Color(0xffb72334),
          foregroundColor: Colors.white70,
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: _text,
            words: _highlights,
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        await _speech.listen(
          onResult: (val) async {
            _text = await val.recognizedWords;
            if (_text == 'news' || _text == 'NEWS') {
              Ho();
            }
            if (_text == 'police' || _text == 'POLICE') {
              Constants.policeStaionFunction();
            }
            if (_text == 'taxi' || _text == 'TAXI') {
              Constants.taxiButton();
            }
            if (_text == 'SOS SMS' || _text == 'sos sms') {
              Constants.sendMessage();
            }
            if (_text == 'SOS call' || _text == 'sos call') {
              service.call(number);
            }
            if (_text == 'siren' || _text == 'SIREN') {
              setState(() {
                Timer(Duration(seconds: 10), () {
                  assetsAudioPlayer.stop();
                  Navigator.pop(context, MaterialPageRoute(builder: (context) => Homes()));
                  print('stop');
                });
                assetsAudioPlayer.open(
                  Audio("music/police.mp3"),
                );
              });
            }
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          },
        );
      }
    } else {
      setState(() {
        _isListening = false;
        Navigator.of(context).pop(Homes());
      });
      _speech.stop();
    }
  }
}
