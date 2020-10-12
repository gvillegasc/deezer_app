import 'package:deezer_app/models/artist_model.dart';
import 'package:dio/dio.dart';

class DeezerAPI {
  DeezerAPI._internal();

  static DeezerAPI _instance = DeezerAPI._internal();
  static DeezerAPI get instance => _instance;

  final Dio _dio = Dio();

  Future<List<ArtistModel>> getArtists() async {
    try {
      final Response response =
          await _dio.get('https://api.deezer.com/genre/0/artists');
      if (response.statusCode == 200) {
        final List<ArtistModel> artists = (response.data['data'] as List)
            .map<ArtistModel>((json) => ArtistModel.fromJson(json))
            .toList();

        return artists;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
