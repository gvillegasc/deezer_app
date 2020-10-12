import 'package:deezer_app/models/artist_model.dart';
import 'package:deezer_app/models/track_model.dart';
import 'package:dio/dio.dart';

class DeezerAPI {
  DeezerAPI._internal();

  static DeezerAPI _instance = DeezerAPI._internal();
  static DeezerAPI get instance => _instance;

  final Dio _dio = Dio(BaseOptions(
      baseUrl: "https://api.deezer.com",
      connectTimeout: 5000,
      receiveTimeout: 10000));

  Future<List<ArtistModel>> getArtists() async {
    try {
      final Response response = await _dio.get('/genre/0/artists');
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

  Future<List<TrackModel>> getTracks(int artistId) async {
    try {
      final Response response =
          await _dio.get('/artist/$artistId/top?limit=50');

      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((json) => TrackModel.fromJson(json))
            .toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
