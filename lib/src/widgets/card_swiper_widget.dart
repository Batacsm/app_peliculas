import 'package:app_peliculas/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> elementos;

  const CardSwiper({super.key, required this.elementos});

  

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 5.0),
      //width: screenSize.width * 0.7,
      height: screenSize.height * 0.5,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: screenSize.width * 0.6,
        //itemHeight: screenSize.height * 0.5,
        itemBuilder: (BuildContext context,int index){
          elementos[index].uniqId = '${elementos[index].id}-cartelera';
          return Hero(
            tag: elementos[index].uniqId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                child: _cargarImagen(index),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'detalle',
                    arguments: elementos[index],
                  );
                },
              ),
            ),
          );
        },
        itemCount: elementos.length,
        //pagination: const SwiperPagination(),
        control: const SwiperControl(
          color: Colors.red,
        ),
      ),
    );
  }

  FadeInImage _cargarImagen(int index) {
    return FadeInImage(
              image: NetworkImage(elementos[index].getPosterImg()),
              placeholder: const AssetImage('assets/loading.gif'),
              fit: BoxFit.cover,
            );
  }
}