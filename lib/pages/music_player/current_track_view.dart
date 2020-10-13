import 'package:cached_network_image/cached_network_image.dart';
import 'package:deezer_app/bloc/music_player/bloc.dart';
import 'package:deezer_app/models/track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentTrackView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = MusicPlayerBloc.of(context);
    return Container(
      child: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
        builder: (_, state) {
          final TrackModel currentTrack =
              bloc.artist.tracks[state.currentTrackIndex];
          return Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                width: 300,
                child: CachedNetworkImage(
                  imageUrl: currentTrack.album.cover,
                ),
              ),
              Text(
                currentTrack.album.title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                currentTrack.title,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${state.currentTrackIndex + 1}/${bloc.artist.tracks.length}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          );
        },
      ),
    );
  }
}
