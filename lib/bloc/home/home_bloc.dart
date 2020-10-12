import 'package:bloc/bloc.dart';
import 'package:deezer_app/api/deezer_api.dart';
import 'package:deezer_app/bloc/home/bloc.dart';
import 'package:deezer_app/models/artist_model.dart';
import 'package:deezer_app/models/track_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_events.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // HomeBloc() : super(HomeState(status: null));
  HomeBloc() : super(HomeState()) {
    add(CheckDbEvent());
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is CheckDbEvent) {
      yield* this._mapCheckDb(event);
    } else if (event is OnSearchEvent) {
      yield this.state.copyWith(searchText: event.searchText);
    } else if (event is OnSelectedEvent) {
      yield* this._mapOnSelected(event);
    } else if (event is DownloadEvent) {
      yield* this._mapDownloadTracks(event);
    }
  }

  Stream<HomeState> _mapDownloadTracks(DownloadEvent event) async* {
    yield this.state.copyWith(status: HomeStatus.downloading);
    for (final ArtistModel artist in event.artistSeleted) {
      final List<TrackModel> tracks =
          await DeezerAPI.instance.getTracks(artist.id);
      print("artist ${artist.id} track: ${tracks.length}");
    }
  }

  Stream<HomeState> _mapOnSelected(OnSelectedEvent event) async* {
    final int id = event.id;
    final List<ArtistModel> tmp = List.from(this.state.artists);
    final int index = tmp.indexWhere((element) => element.id == id);
    if (index != -1) {
      tmp[index] = tmp[index].onSelected();
      yield this.state.copyWith(artists: tmp);
    }
  }

  Stream<HomeState> _mapCheckDb(CheckDbEvent event) async* {
    await Future.delayed(Duration(seconds: 2));
    final List<ArtistModel> artists = await DeezerAPI.instance.getArtists();
    if (artists != null) {
      yield this.state.copyWith(status: HomeStatus.selecting, artists: artists);
    } else {
      yield this.state.copyWith(status: HomeStatus.error);
    }
  }

  static HomeBloc of(BuildContext context) {
    return BlocProvider.of<HomeBloc>(context);
  }
}
