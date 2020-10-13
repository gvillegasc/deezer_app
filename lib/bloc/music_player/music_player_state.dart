import 'package:equatable/equatable.dart';

class MusicPlayerState extends Equatable {
  final int currentTrackIndex;

  MusicPlayerState({
    this.currentTrackIndex,
  });

  static MusicPlayerState initialState() {
    return MusicPlayerState(currentTrackIndex: 0);
  }

  @override
  List<Object> get props => [currentTrackIndex];
}
