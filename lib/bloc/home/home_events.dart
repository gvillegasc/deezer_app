abstract class HomeEvent {}

class CheckDbEvent extends HomeEvent {}

class LoadArtistsEvent extends HomeEvent {}

class OnSelectArtist extends HomeEvent {}

class OnSearchEvent extends HomeEvent {
  final String searchText;
  OnSearchEvent(this.searchText);
}

class DownloadEvent extends HomeEvent {}

class OnSelectedEvent extends HomeEvent {
  final int id;
  OnSelectedEvent(this.id);
}
