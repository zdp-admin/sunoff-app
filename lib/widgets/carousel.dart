import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/models/cotizacion/image_film.dart';

Widget carousel(List<ImageFilm> images) {
  return CarouselSlider(
      options: CarouselOptions(
          autoPlay: false,
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          enlargeCenterPage: true,
          height: 340,
          autoPlayInterval: Duration(seconds: 4)),
      items: images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: PColors.pDarkBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FadeInImage(
                    image: NetworkImage(image.linkImage),
                    placeholder: AssetImage('assets/images/Pulse.gif'),
                    fit: BoxFit.contain,
                    imageErrorBuilder:
                        (BuildContext ctxerror, Object obj, StackTrace? stack) {
                      return Image(
                          height: 100,
                          image: AssetImage('assets/images/default_image.png'),
                          fit: BoxFit.none);
                    }));
          },
        );
      }).toList());
}
