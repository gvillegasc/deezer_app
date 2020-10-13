import 'package:deezer_app/bloc/music_player/bloc.dart';
import 'package:equatable/equatable.dart';

class MusicPlayerState extends Equatable {
  final int currentTrackIndex;

  MusicPlayerState({
    this.currentTrackIndex,
  });

  MusicPlayerState copyWith({int currentTrackIndex}) {
    return MusicPlayerState(
        currentTrackIndex: currentTrackIndex ?? this.currentTrackIndex);
  }

  static MusicPlayerState initialState() {
    return MusicPlayerState(currentTrackIndex: 0);
  }

  @override
  List<Object> get props => [currentTrackIndex];
}
