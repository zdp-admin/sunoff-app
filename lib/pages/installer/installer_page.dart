import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:sunoff/colors/light_colors.dart';
import 'package:sunoff/services/setup_service.dart';
import 'package:sunoff/utils/app_settings.dart';
import 'package:sunoff/utils/preference_user.dart';
import 'package:sunoff/widgets/app_bar_custom.dart';
import 'package:sunoff/widgets/drawer_custom.dart';

class InstallerPage extends StatefulWidget {
  @override
  InstallerState createState() => new InstallerState();
}

class InstallerState extends State<InstallerPage> {
  PreferencesUser pref = new PreferencesUser();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> assistant = ['Elmo', 'Auxiliar2', 'Auxiliar3'];
  List<String> typeConst = ['Residencial', 'Comercial', 'Opción 3'];
  String? valueSelectionAux;
  String? valueSelectionConst;
  String _timeIn = '12:00';
  String _timeOut = '00:00';
  int count = 0;

  void _increment() {
    count++;
    setState(() {});
  }

  void _decrement() {
    if (count >= 1) {
      count--;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: this._scaffoldKey,
        backgroundColor: appService<AppSettings>().appTheme!.backgroundColor,
        appBar: appBarCustom(context),
        drawer: drawerCustom(context),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: 25),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue[50],
                  child: Text('Agregar Instalación:',
                      style: TextStyle(
                        fontSize: 36,
                      ))),
              Column(
                children: [
                  Text(
                    'Registra los siguientes datos:',
                    style: TextStyle(fontSize: 22),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(children: [
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Domicilio',
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 10),
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius: BorderRadius.circular(4)),
                          child: DropdownButton(
                            underline: SizedBox(),
                            isExpanded: true,
                            hint: Text('Auxiliar'),
                            value: valueSelectionAux,
                            onChanged: (value) => {
                              setState(() {
                                valueSelectionAux = value as String;
                              })
                            },
                            items: assistant.map((valueItems) {
                              return DropdownMenuItem(
                                value: valueItems,
                                child: Text(valueItems),
                              );
                            }).toList(),
                          )),
                      SizedBox(height: 10),
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius: BorderRadius.circular(4)),
                          child: DropdownButton(
                            underline: SizedBox(),
                            isExpanded: true,
                            hint: Text('Tipo de Construcción'),
                            value: valueSelectionConst,
                            onChanged: (value) => {
                              setState(() {
                                valueSelectionConst = value as String;
                              })
                            },
                            items: typeConst.map((valueItems) {
                              return DropdownMenuItem(
                                value: valueItems,
                                child: Text(valueItems),
                              );
                            }).toList(),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue[50]),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(children: [
                                Text('Hora de Llegada'),
                                TextButton(
                                    onPressed: () {
                                      DatePicker.showTimePicker(context,
                                          onChanged: (_timeIn) {
                                        print('change $_timeIn');
                                      }, onConfirm: (timeIn) {
                                        print('Confirm $timeIn');
                                        _timeIn =
                                            DateFormat.Hm().format(timeIn);
                                        setState(() {});
                                      },
                                          showSecondsColumn: false,
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.es);
                                    },
                                    child: Text(
                                      '$_timeIn',
                                      style: TextStyle(fontSize: 20),
                                    ))
                              ]),
                              Column(children: [
                                Text('Hora de salida.'),
                                TextButton(
                                    onPressed: () {
                                      DatePicker.showTimePicker(context,
                                          onChanged: (_timeOut) {
                                        print('change $_timeOut');
                                      }, onConfirm: (timeOut) {
                                        print('Confirm $timeOut');
                                        _timeOut =
                                            DateFormat.Hm().format(timeOut);
                                        setState(() {});
                                      },
                                          showSecondsColumn: false,
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.es);
                                    },
                                    child: Text(
                                      '$_timeOut',
                                      style: TextStyle(fontSize: 20),
                                    )),
                              ]),
                            ]),
                      ),
                      SizedBox(height: 20),
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Container(
                                child: Text('Vidrios Instalados',
                                    style: TextStyle(fontSize: 18))),
                            Container(
                              width: 130,
                              decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      child: CircleAvatar(
                                        radius: 15,
                                        child: Icon(Icons.remove),
                                      ),
                                      onTap: () {
                                        _decrement();
                                      }),
                                  VerticalDivider(),
                                  Text(
                                    '$count',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  VerticalDivider(),
                                  GestureDetector(
                                      child: CircleAvatar(
                                        radius: 15,
                                        child: Icon(Icons.add),
                                      ),
                                      onTap: () {
                                        _increment();
                                      }),
                                ],
                              ),
                            ),
                          ])),
                      SizedBox(height: 20),
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Container(
                                child: Text('m2 totales instalados',
                                    style: TextStyle(fontSize: 18))),
                            Container(
                                padding: EdgeInsets.only(left: 10),
                                width: 130,
                                child: Expanded(
                                    flex: 1,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          border: OutlineInputBorder()),
                                      keyboardType: TextInputType.number,
                                    ))),
                          ])),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Peliculas:',
                              style: TextStyle(fontSize: 22),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              height: 48,
                              width: 40,
                              child: FloatingActionButton(
                                  backgroundColor: PColors.pDarkBlue,
                                  child: Container(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {}),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: TextField(
                          autofocus: true,
                          minLines: 3,
                          maxLines: 6,
                          decoration: InputDecoration(
                              labelText: 'Comentario',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        child: Text(
                          'Guardar',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {},
                      )
                    ]),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
