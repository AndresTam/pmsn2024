import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:app01/model/actors_model.dart';
import 'package:app01/model/trailer_model.dart';
import 'package:app01/network/api_popular.dart';
import 'package:app01/model/popular_model.dart';
import 'package:app01/model/session_tmdb_model.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({super.key});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {

  ApiPopular? apiPopular;
  String trailerKey = '';
  String baseUrl = 'https://image.tmdb.org/t/p/w500/';
  late Color iconColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Inicializa antes de todo
    apiPopular = ApiPopular();
    iconColor = Colors.white;
  }

  Color _getIconColor(bool favorites) {
    return favorites ? Colors.red : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    final PopularModel popularModel = args['popularMovies'] as PopularModel;
    final List<TrailerModel> trailers = args['trailers'];
    final List<ActorsModel> actors = args['actors'];
    late bool favorites = args['favorites'];
    String? sessionId = SessionManager().getSessionId();

    if(trailers.isNotEmpty){
      for(var trailer in trailers) {
        if(trailer.type == "Trailer" && trailer.name.contains("Tráiler Oficial")){
          trailerKey = trailer.key;
          break;
        }
      }
    }

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: trailerKey,
      flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
      ),
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('$baseUrl${popularModel.posterPath!}'),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0), 
          child: Container(
            color: Colors.black.withOpacity(0.3), // Color de fondo con opacidad
            child: Center(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35.0),
                    child: trailerKey != '' 
                      ? YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.amber,
                            progressColors: const ProgressBarColors(
                              playedColor: Colors.amber,
                              handleColor: Colors.amberAccent,
                            ),
                          ),
                          builder: (context, player){
                              return Column(
                                  children: [
                                      player,
                                  ],
                              );
                            }
                          )
                      : Container(
                          height: 180,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                          child: const Text(
                            "Esta pelicula no cuenta con trailer",
                            style:  TextStyle(
                              fontSize: 35, // Tamaño de fuente
                              color: Colors.white, // Color de fuente
                              fontWeight: FontWeight.bold, // Peso de fuente (bold)
                            ),
                            textAlign: TextAlign.center,
                          )
                        )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              iconColor = iconColor == Colors.white ? Colors.red : Colors.white;
                            });
                            favorites
                              ? ApiPopular().removeFromFavorites(popularModel.id!, sessionId!)
                              : ApiPopular().addToFavorites(popularModel.id!, sessionId!);
                            // Mostrar un SnackBar
                            final snackBar = SnackBar(
                              content: Text(
                                favorites ? 'Eliminado de favoritos' : 'Agregado a favoritos',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: favorites ? Colors.red : Colors.green,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                          child: Icon(
                            Ionicons.heart,
                            color: _getIconColor(favorites),
                            size: 40.0,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: RatingStars(
                            value: popularModel.voteAverage!,
                            starBuilder: (index, color) => Icon(
                              Icons.star,
                              color: color,
                            ),
                            starCount: 5,
                            starSize: 20,
                            valueLabelColor: const Color(0xff9b9b9b),
                            valueLabelTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            valueLabelRadius: 10,
                            maxValue: 10,
                            starSpacing: 2,
                            maxValueVisibility: true,
                            valueLabelVisibility: true,
                            animationDuration: Duration(milliseconds: 1000),
                            valueLabelPadding:
                                const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                            valueLabelMargin: const EdgeInsets.only(right: 8),
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0),
                    child: Text(
                      popularModel.title!,
                      style: const TextStyle(
                        fontSize: 35, // Tamaño de fuente
                        color: Colors.white, // Color de fuente
                        fontWeight: FontWeight.bold, // Peso de fuente (bold)
                      ),
                      textAlign: TextAlign.center, // Alineación del texto (derecha)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0),
                    child: Text(
                      popularModel.overview!,
                      style: const TextStyle(
                        fontSize: 20, // Tamaño de fuente
                        color: Colors.white, // Color de fuente
                        fontWeight: FontWeight.bold, // Peso de fuente (bold)
                      ),
                      textAlign: TextAlign.justify, // Alineación del texto (derecha)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0),
                    child: Text(
                      'Fecha de lanzamiento ${popularModel.releaseDate!}',
                      style: const TextStyle(
                        fontSize: 17, // Tamaño de fuente
                        color: Colors.white, // Color de fuente
                        fontWeight: FontWeight.normal, // Peso de fuente (bold)
                      ),
                      textAlign: TextAlign.justify, // Alineación del texto (derecha)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0),
                    child: Text(
                      'Clasificación: ${popularModel.adult == false ? 'Todo publico' : "Adultos"}',
                      style: const TextStyle(
                        fontSize: 17, // Tamaño de fuente
                        color: Colors.white, // Color de fuente
                        fontWeight: FontWeight.normal, // Peso de fuente (bold)
                      ),
                      textAlign: TextAlign.justify, // Alineación del texto (derecha)
                    ),
                  ),
                  Container(
                    height: 250, // Altura deseada del ListView
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: actors.length,
                      itemBuilder: (context, index) {
                        final actor = actors[index];
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8), // Opcional: puedes ajustar el radio de las esquinas si lo deseas
                                  child: Image.network(
                                    actor.profilePath.isNotEmpty 
                                      ? '$baseUrl${actor.profilePath}'
                                      : "https://i.pinimg.com/236x/70/85/54/7085548f3d0372a08aea0291ddcee895.jpg", //URL generica
                                    width: 100, // Ancho deseado de la imagen
                                    height: 120, // Altura deseada de la imagen
                                    fit: BoxFit.cover, // Ajusta la imagen para que cubra todo el espacio disponible
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  actor.name, // Nombre del actor
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  actor.character, // Nombre del personaje
                                  style: TextStyle(fontSize: 13, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}