import 'package:deezer_app/models/artist_model.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { checking, loading, selecting, downloading, ready, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ArtistModel> artists;
  final String searchText;

  HomeState(
      {this.status = HomeStatus.checking, this.artists, this.searchText = ""});

  static HomeState get initialState =>
      HomeState(status: HomeStatus.checking, artists: const [], searchText: '');

  HomeState copyWith(
      {HomeStatus status, List<ArtistModel> artists, String searchText}) {
    return HomeState(
        status: status ?? this.status,
        artists: artists ?? this.artists,
        searchText: searchText ?? this.searchText);
  }

  @override
  List<Object> get props => [status, artists, searchText];
}
