import 'moviepage.dart';
import 'package:http/http.dart' as http;
import 'package:assign3/main.dart';

class RemoteService {
  Future<List<Result>?> getTrendingMovies() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=381635c3cadc9236f5419d4f8dea317e&language=en-US&page=1');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return movieFromJson(json).results;
    }
    return null;
  }

  Future<List<Result>?> getTopRatedMovies() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=381635c3cadc9236f5419d4f8dea317e&language=en-US&page=1');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return movieFromJson(json).results;
    }
    return null;
  }

  Future<List<Result>?> getNowPlayingMovies() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=381635c3cadc9236f5419d4f8dea317e&language=en-US&page=1');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return movieFromJson(json).results;
    }
    return null;
  }
}
