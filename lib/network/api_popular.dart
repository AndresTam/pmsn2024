//import 'dart:convert';
import 'package:app01/model/popular_model.dart';
import 'package:dio/dio.dart';

class ApiPopular{
  final dio = Dio();
  final Url = "https://api.themoviedb.org/3/movie/popular?api_key=45d69ee8ce7b6736b37ab4bc080fb3e2&language=es-MX&page=1";

  Future<List<PopularModel>?> getPopularMovie() async{ //Todo lo que involucre cosas asincronas se debe de usar future.
    Response response = await dio.get(Url); //Si fuera con una uri se tendria que parsear
    
    if(response.statusCode == 200){

      //print(response.data['results'].runtimeType); Comprueba si hay cosas en el response y el runtimeType dice de que tipo es lo recibido

      final listMovies = response.data['results'] as List; //Con este parseo se obtiene los elementos de la respuesta ya que no esta directo en el data
      return listMovies.map((movie) => PopularModel.fromMap(movie)).toList();// Quitamos el jsonDecode porque ya regresaba una lista tal cual y no era necesario
    }
    return null;
  }
}