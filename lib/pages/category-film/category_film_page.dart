import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/models/cotizacion/image_film.dart';
import 'package:sunoff/models/cotizacion/pelis.dart';
import 'package:sunoff/services/rest_service.dart';
import 'package:sunoff/widgets/app_bar_custom.dart';
import 'package:sunoff/widgets/carousel.dart';
import '../../services/setup_service.dart';
import '../../utils/app_settings.dart';
import '../../utils/preference_user.dart';
import '../../widgets/drawer_custom.dart';

class PeliDetailsPage extends StatefulWidget {
  final int categoryId;
  PeliDetailsPage({required this.categoryId});

  @override
  PeliDetailsPageState createState() => new PeliDetailsPageState();
}

class PeliDetailsPageState extends State<PeliDetailsPage>
    with SingleTickerProviderStateMixin {
  PreferencesUser pref = new PreferencesUser();
  late List<Pelis> _pelis = [];
  int _selectedIndex = 0;
  List<ImageFilm> images = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    this.getImagesFilm();
  }

  void getImagesFilm() {
    RestService().getPelis(categoryId: widget.categoryId).then((value) {
      setState(() {
        this._pelis = value;
      });
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        duration: Duration(seconds: 3),
        content:
            Text(onError is String ? onError : 'Error al consultar las Pelis'),
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
                  margin: EdgeInsets.only(top: 2),
                  child: LinearProgressIndicator(),
                )
              : Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      carousel(this.activePeli.images, context),
                      SizedBox(height: 15),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: Column(children: [
                          Text(this.activePeli.name,
                              style: TextStyle(
                                  color: PColors.pDarkBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32)),
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
            height: 55.0,
            decoration: BoxDecoration(
              color: PColors.pLightBlue,
            ),
            child: Center(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: GNav(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    tabMargin:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    curve: Curves.easeIn,
                    gap: 3,
                    textStyle: TextStyle(fontSize: 16),
                    activeColor: PColors.pLightBlue,
                    tabBackgroundColor: Colors.white,
                    tabs: this
                        ._pelis
                        .map((peli) => GButton(
                              icon: Icons.window,
                              iconColor: Colors.white,
                              activeBorder: Border(
                                bottom: BorderSide.none,
                              ),
                              textStyle: TextStyle(fontSize: 16),
                              text: '${peli.name}',
                            ))
                        .toList(),
                    selectedIndex: _selectedIndex,
                    onTabChange: (int index) {
                      setState(() {
                        this._selectedIndex = index;
                      });
                    },
                  )),
            )));
  }
}
