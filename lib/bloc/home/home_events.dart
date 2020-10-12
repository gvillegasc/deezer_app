import 'package:deezer_app/bloc/home/bloc.dart';

abstract class HomeEvent {}

class CheckDbEvent extends HomeEvent {}

class LoadArtistsEvent extends HomeEvent {}

class OnSelectArtist extends HomeEvent {}

class OnSearchEvent extends HomeEvent {}

class DownloadEvent extends HomeEvent {}
