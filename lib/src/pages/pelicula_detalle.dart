import 'package:app_peliculas/src/models/pelicula_model.dart';
import 'package:app_peliculas/src/providers/peliculas_providers.dart';

import 'package:flutter/material.dart';

import '../models/actores_model.dart';

class PeliculaDetalle extends StatelessWidget {
  const PeliculaDetalle({super.key,});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Pelicula pelicula =
          ModalRoute.of(context)!.settings.arguments as Pelicula;
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 36, 34, 34),
      body: CustomScrollView(
        slivers: [
          _crearAppBar(pelicula, context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: size.height * 0.02,),
                _posterPrincipal(pelicula, context),
                _descripcion(pelicula, context),
                _mostrarCast(pelicula, context),
              ]
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _crearAppBar(Pelicula pelicula, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SliverAppBar(
      elevation: 0.0,
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.29,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.5),
          ),
          child: Text(
            pelicula.title!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 11.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: const AssetImage('assets/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

Widget _posterPrincipal(Pelicula pelicula, BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
    child: Row(
      children: [
        Hero(
          tag: pelicula.uniqId!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: size.height * 0.25,
            ),
          ),
        ),
        SizedBox(width: size.width * 0.05,),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pelicula.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
              SizedBox(height: size.height * 0.02,),
              Text(
                pelicula.originalTitle!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.white,),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  Text(
                    pelicula.voteAverage.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _descripcion(Pelicula pelicula, BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: (size.width * 0.05),
      vertical: (size.height * 0.02),
    ),
    child: Text(
      pelicula.overview.toString(),
      textAlign: TextAlign.justify,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    ),
  );
}

Widget _mostrarCast(Pelicula pelicula, BuildContext context) {
  final peliProvider = PeliculasProvider();

  return FutureBuilder(
    future: peliProvider.getActores(pelicula.id.toString()),
    builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {

      if(snapshot.hasData){
        return _crearActoresView(snapshot.data, context);
      }else{
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

Widget _crearActoresView(List<Actor>? actores, BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return SizedBox(
    height: size.height * 0.25,
    child: PageView.builder(
      pageSnapping: false,
      controller: PageController(
        initialPage: 1,
        viewportFraction: 0.3,
      ),
      itemCount: actores?.length,
      itemBuilder: (context, index) {
        return _tarjetaActor(actores![index], context);
      },
    ),
  );
}

Widget _tarjetaActor(Actor actor, BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage(
          height: size.height * 0.2,
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(actor.getActorFoto()),
          fit: BoxFit.cover,
        ),
      ),
      Text(
        actor.name.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    ],
  );
}