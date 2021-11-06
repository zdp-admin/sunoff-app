import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/models/cotizacion/cotizacion_model.dart';
import 'package:sunoff/pages/pricing-details/pricing_details_page.dart';
import 'package:sunoff/services/rest_service.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';
import 'package:sunoff/widgets/app_bar_custom.dart';
import 'package:sunoff/widgets/drawer_custom.dart';

class PricingPage extends StatefulWidget {
  @override
  PricingState createState() => PricingState();
}

class PricingState extends State<PricingPage> {
  late DateTime _selectedDate = DateTime.now();
  bool _folded = true;
  List<CotizacionModel> cotizations = [];

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
    this.getCotizations();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  void getCotizations() {
    appService<RestService>().getPricing().then((value) {
      {
        this.cotizations = value;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context),
      drawer: drawerCustom(context),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Presupuestos', style: TextStyle(fontSize: 28)),
                      AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          width: _folded
                              ? 50
                              : MediaQuery.of(context).size.width * .5,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(230),
                              boxShadow: kElevationToShadow[2]),
                          child: Row(children: [
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.only(left: 16),
                              child: !_folded
                                  ? TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Buscar',
                                          hintStyle: TextStyle(
                                              color: PColors.pLightBlue),
                                          border: InputBorder.none))
                                  : null,
                            )),
                            AnimatedContainer(
                              margin: EdgeInsets.only(right: 12),
                              duration: Duration(milliseconds: 400),
                              child: InkWell(
                                child: Center(
                                    child: Icon(
                                        _folded ? Icons.search : Icons.close)),
                                onTap: () {
                                  setState(() {
                                    _folded = !_folded;
                                  });
                                },
                              ),
                            )
                          ])),
                    ]),
              ),
              CalendarTimeline(
                showYears: false,
                initialDate: _selectedDate,
                firstDate: new DateTime(1950, 1, 1),
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date!;
                  });
                },
                leftMargin: 20,
                monthColor: Colors.black,
                dayColor: Colors.black,
                dayNameColor: Colors.white,
                activeDayColor: Colors.white,
                activeBackgroundDayColor:
                    appService<AppSettings>().appTheme!.primaryColor,
                dotsColor: Color(0xFF333A47),
                locale: 'es_MX',
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.teal[200])),
                  child:
                      Text('RESET', style: TextStyle(color: Color(0xFF333A47))),
                  onPressed: () => setState(() => _resetSelectedDate()),
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              Container(
                child: Column(
                  children: this
                      .cotizations
                      .map((cotization) => Container(
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: Icon(
                                    Icons.contact_page,
                                    size: 20,
                                  )),
                              title: Text(
                                cotization.cliente.name,
                                style: TextStyle(fontSize: 26),
                              ),
                              subtitle: Text(cotization.cliente.address,
                                  style: TextStyle(fontSize: 18)),
                              isThreeLine: true,
                              enabled: true,
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PricingDetailsPage(
                                              cotization: cotization,
                                            )))
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
