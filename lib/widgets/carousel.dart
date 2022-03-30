import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunoff/models/cotizacion/image_film.dart';

Widget carousel(List<ImageFilm> images, context) {
  Size size = MediaQuery.of(context).size;
  return CarouselSlider(
      options: CarouselOptions(
          autoPlay: false,
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          enlargeCenterPage: true,
          height: size.width < 700 ? 340 : 450,
          autoPlayInterval: Duration(seconds: 4)),
      items: images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FadeInImage(
                      image: NetworkImage(image.linkImage),
                      placeholder: AssetImage('assets/images/Pulse.gif'),
                      fit: BoxFit.contain,
                      imageErrorBuilder: (BuildContext ctxerror, Object obj,
                          StackTrace? stack) {
                        return Image(
                            height: 100,
                            image:
                                AssetImage('assets/images/default_image.png'),
                            fit: BoxFit.none);
                      })),
            );
          },
        );
      }).toList());
}
