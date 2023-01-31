import 'dart:async';
import 'dart:convert';

import 'package:app_peliculas/src/models/actores_model.dart';
import 'package:app_peliculas/src/models/pelicula_model.dart';

import 'package:http/http.dart' as http;


class PeliculasProvider {

  final String _apiKey = 'cd70385b6e52c7ae3fcd06c03cfb3b54';
  final String _url = 'api.themoviedb.org';
  final String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  final List<Pelicula> _populares = [];

  final _popularesStreaming = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>)  get popularesSink => _popularesStreaming.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreaming.stream;

  void disposeStreams() {
    _popularesStreaming.close();
  }

  Future<List<Pelicula>> _calcularRespuesta(Uri url) async {

    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    return peliculas.lasPeliculas;
  }

  Future<List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apiKey,
      'language' : _language,
    });

    return await _calcularRespuesta(url);
    
  }

  Future<List<Pelicula>> getPopulares() async{

    if(_cargando) return[];

    _cargando = true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'  : _apiKey,
      'language' : _language,
      'page'     : _popularesPage.toString(),
    });

    final resp = await _calcularRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;

    return resp;

  }

  Future<List<Actor>> getActores(String peliId) async{

    final url = Uri.https(_url, '3/movie/$peliId/credits',{
      'api_key'  : _apiKey,
      'language' : _language,
    });
    final resp = await http.get(url);
    final decodedData = jsonDecode(resp.body);
    final cast = Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async{
    final url = Uri.https(_url, '3/search/movie', {
      'api_key'  : _apiKey,
      'language' : _language,
      'query'    : query,
    });
    return await _calcularRespuesta(url);
  }
}