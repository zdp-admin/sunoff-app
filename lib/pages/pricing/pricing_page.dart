import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/models/cotizacion/cotizacion_model.dart';
import 'package:sunoff/models/user.dart';
import 'package:sunoff/pages/pricing-details/pricing_details_page.dart';
import 'package:sunoff/services/rest_service.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';
import 'package:sunoff/widgets/drawer_custom.dart';

class PricingPage extends StatefulWidget {
  @override
  PricingState createState() => PricingState();
}

class PricingState extends State<PricingPage> {
  late DateTime _selectedDate = DateTime.now();
  bool _folded = true;
  List<CotizacionModel> cotizations = [];
  List<User> users = [];
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Buscar...');

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void selectDate(String date) {
    RestService().getPricing('', date.toString()).then((value) {
      {
        setState(() {
          this.cotizations = value;
        });

        if (this.cotizations.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            duration: Duration(seconds: 3),
            content: Text('No hay registros este día.'),
          ));
        }
      }
    });

    setState(() {});
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
    RestService().getPricing('', DateTime.now().toString()).then((value) {
      {
        setState(() {
          this.cotizations = value;
        });

        if (this.cotizations.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            duration: Duration(seconds: 3),
            content: Text('No hay registros este día.'),
          ));
        }
      }
    }).whenComplete(() => null);
  }

  void getCotizations(String? search) {
    RestService().getPricing(search ?? '', '').then((value) {
      {
        setState(() {
          this.cotizations = value;
        });
        if (this.cotizations.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            duration: Duration(seconds: 3),
            content: Text('Sin coincidencias de búsqueda.'),
          ));
        }
      }
    }).onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [_searchBar()],
        centerTitle: true,
      ),
      drawer: drawerCustom(context),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButton(),
                      Text('Presupuestos',
                          style: TextStyle(
                              fontSize: 28, fontStyle: FontStyle.italic)),
                      Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.lightBlueAccent)),
                          child: Text('Hoy',
                              style: TextStyle(color: Color(0xFF333A47))),
                          onPressed: () => setState(() => _resetSelectedDate()),
                        ),
                      ),
                    ]),
              ),
              _calendarLine(),
              SizedBox(height: 20),
              Divider(),
              Container(
                child: this.cotizations.length <= 0
                    ? Container(
                        child: LinearProgressIndicator(),
                      )
                    : this.cotizations.isEmpty
                        ? Center(child: Text('Sin registros.'))
                        : Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 2),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 30.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(
                                        0.0,
                                        0.0,
                                      ))
                                ]),
                                child: Column(
                                  children: this
                                      .cotizations
                                      .reversed
                                      .map((cotization) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.white,
                                            ),
                                            margin: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 8),
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                  backgroundColor:
                                                      PColors.pLightBlue,
                                                  radius: 20,
                                                  child: Text(cotization
                                                              .userId ==
                                                          4
                                                      ? 'Glady'.substring(0, 2)
                                                      : cotization.userId == 5
                                                          ? 'Paula'
                                                              .substring(0, 3)
                                                          : 'Francisco'
                                                              .substring(
                                                                  0, 2))),
                                              title: Text(
                                                cotization.cliente.name,
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    color: PColors.pLightBlue),
                                              ),
                                              subtitle: Text(
                                                  cotization.cliente.address,
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              //isThreeLine: true,
                                              enabled: true,
                                              onTap: () => {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PricingDetailsPage(
                                                              cotization:
                                                                  cotization,
                                                            )))
                                              },
                                              /*trailing: ElevatedButton(
                                                onPressed: () => {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MeasuresDetails(
                                                                cotization:
                                                                    cotization,
                                                              )))
                                                },
                                                child: Text('Interno'),
                                              ),*/
                                            ),
                                          ))
                                      .toList(),
                                ),
                              )
                            ],
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer _searchBar() {
    return AnimatedContainer(
        duration: Duration(milliseconds: 400),
        width: _folded ? 50 : MediaQuery.of(context).size.width * .9,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(230),
        ),
        child: Row(children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 16),
            child: !_folded
                ? TextField(
                    textInputAction: TextInputAction.go,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      hintStyle: TextStyle(
                          color: Colors.white, fontStyle: FontStyle.italic),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        getCotizations(value);
                      });
                    })
                : null,
          )),
          AnimatedContainer(
            margin: EdgeInsets.only(right: 12),
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 500),
            child: InkWell(
              child: Center(child: Icon(_folded ? Icons.search : Icons.close)),
              onTap: () {
                _folded = !_folded;
                setState(() {});
              },
            ),
          )
        ]));
  }

  Widget _calendarLine() {
    return CalendarTimeline(
      showYears: false,
      initialDate: _selectedDate,
      firstDate: new DateTime(1950, 1, 1),
      lastDate: DateTime.now().add(Duration(days: 365)),
      onDateSelected: (date) {
        setState(() {
          _selectedDate = date!;

          String strdate = date.toString();
          selectDate(strdate.substring(0, strdate.length - 13));
        });
      },
      leftMargin: 70,
      monthColor: Colors.black,
      dayColor: Colors.black,
      dayNameColor: Colors.white,
      activeDayColor: Colors.white,
      activeBackgroundDayColor:
          appService<AppSettings>().appTheme!.primaryColor,
      dotsColor: Color(0xFF333A47),
      locale: 'es_MX',
    );
  }
}
