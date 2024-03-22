import 'package:app01/model/session_tmdb_model.dart';
import 'package:flutter/material.dart';
import 'package:app01/model/popular_model.dart';
import 'package:app01/network/api_popular.dart';

class FavoritesMoviesScreen extends StatefulWidget {
  const FavoritesMoviesScreen({super.key});

  @override
  State<FavoritesMoviesScreen> createState() => _FavoritesMoviesScreenState();
}

class _FavoritesMoviesScreenState extends State<FavoritesMoviesScreen> {
  
  ApiPopular? apiPopular;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Inicializa antes de todo
    apiPopular = ApiPopular();
  }
  
  @override
  Widget build(BuildContext context) {
    String? sessionId = SessionManager().getSessionId();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas Favoritas'),
      ),
      body: FutureBuilder(
        future: apiPopular!.getFavoriteMovies(sessionId!),
        builder: (context,AsyncSnapshot<List<PopularModel>?> snapshot){ //El snapshot trae cada elemento del arreglo (Es una lista del popular model)
          if (snapshot.hasData) {
            return GridView.builder(//Se puede poner un .builder a un contenedor cuando no se cauntos elementos hay
              itemCount: snapshot.data!.length, //Le indica la cantidad de elementos a mostrar para que no de error mostrando muchas cosas
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //El numero de columnas a mostrar
                childAspectRatio: .7, //Se recomienda dejarlo bajo
                mainAxisSpacing: 10, //La separacion de cada elemento
              ), 
              itemBuilder: (context,index){
                return GestureDetector( //Se usa para poder darle un evento a un widgets que no tenga ontap
                  onTap: () async{
                    final trailers = await apiPopular!.getMovieTrailers(snapshot.data![index].id!);
                    final actors = await apiPopular!.getMovieActors(snapshot.data![index].id!);
                    
                    Navigator.pushNamed(context, "/detail", arguments: {
                      'popularMovies' : snapshot.data![index],
                      'trailers' : trailers,
                      'actors' : actors,
                      'favorites' : true,
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage(// Aplica un efecto de difuminado
                      placeholder: const AssetImage("images/loading.gif"),
                      image: NetworkImage("https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}"),
                    ),
                  ),
                );
              },
            );
          }else{
            if(snapshot.hasError){
              return const Center(child: Text("Ocurrio un error..."),);
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          }
        },
      ),
    );
  }
}