import 'package:bloc/bloc.dart';
import 'package:deezer_app/api/deezer_api.dart';
import 'package:deezer_app/bloc/home/bloc.dart';
import 'package:deezer_app/models/artist_model.dart';
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
    }
  }

  Stream<HomeState> _mapCheckDb(CheckDbEvent event) async* {
    await Future.delayed(Duration(seconds: 2));
    final List<ArtistModel> artists = await DeezerAPI.instance.getArtists();
    if (artists != null) {
      yield this
          .state
          .copyWith(status: HomeStatus.seletecing, artists: artists);
    } else {
      yield this.state.copyWith(status: HomeStatus.error);
    }
  }
}
