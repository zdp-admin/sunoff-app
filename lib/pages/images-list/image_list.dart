import 'package:flutter/material.dart';
import 'package:sunoff/pages/images-list/widget/image_view.dart';

class ImagesPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<ImagesPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Galería de la Sección'),
      ),
      body: new Center(
        child: new ListView(
          children: [
            imageView('assets/images/SunOffw.png'),
            imageView('assets/images/blanco-mate/02.PNG'),
            imageView('assets/images/blanco-mate/03.PNG'),
            imageView('assets/images/blanco-mate/04.PNG'),
          ],
        ),
      ),
    );
  }
}
