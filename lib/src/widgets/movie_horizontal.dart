import 'package:app_peliculas/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {

    final List<Pelicula> elementos;

    final Function siguientePagina;

    final _pageController = PageController(
      initialPage : 1,
      viewportFraction : 0.3,
    );

    MovieHorizontal({super.key, required this.elementos, required this.siguientePagina});

    @override Widget build(BuildContext context) {

        final screanSize = MediaQuery.of(context).size;

        _pageController.addListener((){
          if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 100){
            siguientePagina();
          }
        });

        return SizedBox(
          height : screanSize.height * 0.2,
          child : PageView.builder(
            pageSnapping : false,
            controller : _pageController,
            itemCount: elementos.length,
            itemBuilder: (context, index) {
              return _tarjeta(context, elementos[index]);
            },
            //children : _tarjetas(context),
        ),);
    }

    Widget _tarjeta(BuildContext context, Pelicula pelicula){
      pelicula.uniqId = '${pelicula.id}-popular';
      final tarjetica = Container(
        margin : const EdgeInsets.only(right : 10.0),
        child : Column(
          children : [
            Hero(
              tag: pelicula.uniqId!,
              child: ClipRRect(
                borderRadius : BorderRadius.circular(10.0),
                child : FadeInImage(
                  placeholder : const AssetImage('assets/loading.gif'),
                  image : NetworkImage(pelicula.getPosterImg()),
                  fit : BoxFit.cover,
                  height : MediaQuery.of(context).size.height * 0.18,
                  ),
              ),
            ),
            Text(
              pelicula.title !,
              overflow : TextOverflow.ellipsis,
              style : const TextStyle(
                color: Colors.white,
                fontSize : 7.7
              ),
            )
          ],
        ),
      );
      return GestureDetector(
        child: tarjetica,
        onTap: () {
          Navigator.pushNamed(
            context,
            'detalle',
            arguments: pelicula,
          );
        },
      );
    }
}