import 'package:bloc/bloc.dart';
import 'package:deezer_app/bloc/music_player/bloc.dart';
import 'package:deezer_app/models/artist_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'music_player_events.dart';
import 'music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final ArtistModel artist;

// MusicPlayerBloc(this.artist);

  MusicPlayerBloc(this.artist) : super(MusicPlayerState.initialState());

  @override
  Stream<MusicPlayerState> mapEventToState(MusicPlayerEvent event) async* {}

  static MusicPlayerBloc of(BuildContext context) {
    return BlocProvider.of<MusicPlayerBloc>(context);
  }
}
