import 'package:deezer_app/models/artist_model.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { checking, loading, seletecing, downloading, ready, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ArtistModel> artists;

  HomeState({this.status = HomeStatus.checking, this.artists});

  static HomeState get initialState =>
      HomeState(status: HomeStatus.checking, artists: const []);

  HomeState copyWith({HomeStatus status, List<ArtistModel> artists}) {
    return HomeState(
        status: status ?? this.status, artists: artists ?? this.artists);
  }

  @override
  List<Object> get props => [status, artists];
}
