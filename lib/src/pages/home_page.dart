import 'package:app_peliculas/src/search/search_delegate.dart';
import 'package:app_peliculas/src/widgets/card_swiper_widget.dart';
import 'package:app_peliculas/src/widgets/movie_horizontal.dart';

import 'package:flutter/material.dart';

import '../providers/peliculas_providers.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 36, 34, 34),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Películas', style: TextStyle(color: Colors.red),),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: (() {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            }),
            icon: const Icon(Icons.search, color: Colors.redAccent,),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _swipperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }
  
  Widget _swipperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if(snapshot.hasData){
          return CardSwiper(
            elementos: snapshot.data,
          );
        }else{
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.7,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
      },
    );

  }
  
  Widget _footer(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Populares', style: TextStyle(
            color: Colors.redAccent,
            fontSize: 20.0,
          )),
          const SizedBox(height: 5.0,),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(
                  elementos: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              }else{
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  )
                );
              }
            },
          ),
        ],
      ),
    );
  }
}