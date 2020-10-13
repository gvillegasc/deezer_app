import 'package:deezer_app/bloc/music_player/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final MusicPlayerBloc bloc = MusicPlayerBloc.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoButton(
          padding: EdgeInsets.all(5),
          color: Color(0xffeeeeee),
          borderRadius: BorderRadius.circular(60),
          child: Icon(
            Icons.skip_previous,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            bloc.add(PrevTrackEvent());
          },
        ),
        SizedBox(
          width: 15,
        ),
        CupertinoButton(
          padding: EdgeInsets.all(5),
          color: Color(0xffeeeeee),
          borderRadius: BorderRadius.circular(60),
          child: Icon(
            Icons.play_arrow,
            size: 45,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        SizedBox(
          width: 15,
        ),
        CupertinoButton(
          padding: EdgeInsets.all(5),
          color: Color(0xffeeeeee),
          borderRadius: BorderRadius.circular(60),
          child: Icon(
            Icons.skip_next,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            bloc.add(NextTrackEvent());
          },
        ),
      ],
    );
  }
}
