import 'package:deezer_app/bloc/music_player/bloc.dart';
import 'package:deezer_app/models/artist_model.dart';
import 'package:deezer_app/pages/music_player/current_track_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MusicPlayerPage extends StatefulWidget {
  final ArtistModel artist;

  const MusicPlayerPage({Key key, @required this.artist})
      : assert(artist != null),
        super(key: key);
  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  MusicPlayerBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MusicPlayerBloc(widget.artist);
  }

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _bloc,
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
              child: Column(
                children: <Widget>[CurrentTrackView()],
              ),
            ),
          ),
        ));
  }
}
