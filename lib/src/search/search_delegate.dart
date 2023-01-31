import 'package:app_peliculas/src/providers/peliculas_providers.dart';
import 'package:flutter/material.dart';

import '../models/pelicula_model.dart';

class DataSearch extends SearchDelegate {

  final peliculasProvider = PeliculasProvider();

  @override
  String get searchFieldLabel => 'Búsqueda';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      hintColor: const Color.fromARGB(255, 204, 197, 197),
      textTheme: const TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 61, 59, 59),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    //Las acciones del AppBar
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Ícono a la izquierda del AppBar
    return IconButton(
      onPressed: () {
        //UnfocusDisposition.previouslyFocusedChild;
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que se van a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if(snapshot.hasData){
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas!.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: const AssetImage('assets/loading.gif'),
                  width: MediaQuery.of(context).size.width * 0.117,
                  fit: BoxFit.contain,
                ),
                title: Text(
                  pelicula.title.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  pelicula.originalTitle.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  pelicula.uniqId = '';
                  close(context, null);
                  Navigator.pushNamed(
                    context,
                    'detalle',
                    arguments: pelicula,
                  );
                },
              );
            }).toList(),
          );
        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

}