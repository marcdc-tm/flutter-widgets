import 'package:flutter/material.dart';

import 'track.dart';

class TrackRij extends StatefulWidget {
  int _index;
  Track _track;
  Function _play;
  Function _pause;
  Function _stop;
  Duration _duration;
  Duration _position;

  TrackRij(this._index, this._track, this._play, this._pause, this._stop, this._duration, this._position);

  _TrackRijState createState() => _TrackRijState();
}

class _TrackRijState extends State<TrackRij> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
        padding: const EdgeInsets.only(top: 5.0),
        decoration: BoxDecoration(border: Border.all()),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
            child: Row(children: [
              Expanded(
                flex: 7,
                child: Container(
                  height: 70,
                  child: Column(children: [
                    Expanded(
                        child: Container(
                            child: RichText(
                                textScaleFactor: 1.2,
                                text: TextSpan(
                                  text: widget._track.title,
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
                                  children: <TextSpan>[
                                    TextSpan(text: "  by ", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300)),
                                    TextSpan(text: widget._track.artist, style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, fontWeight: FontWeight.w300))
                                  ],
                                )))),
                    Expanded(
                        child: Container(
                            child: RichText(
                              text: TextSpan(text: widget._track.album, style: TextStyle(color: Colors.grey, fontSize: 16)),
                            ))),
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: RichText(
                                text: TextSpan(text: widget._track.year.toString() + "     " + widget._track.genre, style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic))
                            ))),
                  ]),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: widget._track.artwork,
                ),
              ),
              Expanded(
                child: Container(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (!widget._track.hasStarted) {
                          widget._stop();
                        }
                        if (widget._track.isPlaying) {
                          widget._pause(widget._track);
                        } else {
                          widget._play(widget._index, widget._track);
                        }
                      });
                    },
                    icon: widget._track.isPlaying ?
                    Icon(Icons.pause, size: 40) :
                    (widget._track.hasStarted ? Icon(Icons.play_circle_outline, size: 40) : Icon(Icons.play_arrow, size: 40)),
                  ),
                ),
              )
            ]),
          ),
          Container(
            height: widget._track.hasStarted ? 5 : 1,
            decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[300]))),
            child: LinearProgressIndicator(
                value: widget._track.hasStarted && widget._duration.inSeconds.toDouble()>0 ? widget._position.inSeconds.toDouble()/widget._duration.inSeconds.toDouble() : 0,
                backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue)),
          ),
        ])
    );
  }
}