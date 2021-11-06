import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:sunoff/models/cotizacion/image_film.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';
import 'package:sunoff/services/rest_service.dart';
import 'package:sunoff/widgets/app_bar_custom.dart';
import 'package:sunoff/widgets/carousel.dart';
import '../../services/setup_service.dart';
import '../../utils/app_settings.dart';
import '../../utils/preference_user.dart';
import '../../widgets/drawer_custom.dart';

class DecorativePage extends StatefulWidget {
  final int categoryId;
  DecorativePage({required this.categoryId});

  @override
  RewardsPageState createState() => new RewardsPageState();
}

class RewardsPageState extends State<DecorativePage>
    with SingleTickerProviderStateMixin {
  PreferencesUser pref = new PreferencesUser();
  List<Pelis> _pelis = [];
  int _selectedIndex = 0;
  List<ImageFilm> images = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    this.getPelis();
  }

  void getPelis() {
    appService<RestService>()
        .getPelis(categoryId: widget.categoryId)
        .then((value) {
      setState(() {
        this._pelis = value;
      });
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
            onError is String ? onError : 'Error al consultar la información'),
      ));
    });
  }

  void getImagesFilm() {
    appService<RestService>()
        .getPelis(categoryId: widget.categoryId)
        .then((value) {
      setState(() {
        this._pelis = value;
      });
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
            onError is String ? onError : 'Error al consultar la información'),
      ));
    });
  }

  Pelis get activePeli {
    return this._pelis.length > 0
        ? this._pelis.elementAt(this._selectedIndex)
        : Pelis.fromJson({});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: appService<AppSettings>().appTheme!.accentColor,
        appBar: appBarCustom(context),
        drawer: drawerCustom(context),
        body: SingleChildScrollView(
          child: this._pelis.length <= 0
              ? Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Container(child: carousel(this.activePeli.images)),
                      SizedBox(height: 15),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: Column(children: [
                          Text(this.activePeli.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 32)),
                          Divider(indent: 100, endIndent: 100),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            width: MediaQuery.of(context).size.width * .9,
                            height: 500,
                            child: Text(
                              this.activePeli.description,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: GNav(
                  tabMargin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  tabActiveBorder: Border.all(color: Colors.blue, width: 1),
                  curve: Curves.easeInCirc,
                  gap: 4,
                  textStyle: TextStyle(fontSize: 16),
                  activeColor: Colors.black,
                  tabBackgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  tabs: this
                      ._pelis
                      .map((peli) => GButton(
                          icon: Icons.window,
                          textStyle: TextStyle(fontSize: 18),
                          text: '${peli.name}'))
                      .toList(),
                  selectedIndex: _selectedIndex,
                  onTabChange: (int index) {
                    setState(() {
                      this._selectedIndex = index;
                    });
                  },
                ))));
  }
}
