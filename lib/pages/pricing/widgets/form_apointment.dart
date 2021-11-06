import 'package:flutter/material.dart';

import 'package:sunoff/pages/pricing/bloc/apointment_bloc.dart';
import '../../../services/setup_service.dart';
import '../../../utils/app_settings.dart';
import '../../../utils/general.dart';

Widget formApointment(
    BuildContext context,
    ApointmentBloc bloc,
    Function submit,
    TextEditingController dateController,
    TextEditingController timeController) {
  return Column(children: [
    Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text('Selecciona tu fecha deseada',
                style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          Container(
              child: StreamBuilder(
            stream: bloc.dateStream,
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              return TextField(
                onTap: () {
                  appService<General>().selectDate(context, bloc.date!,
                      (DateTime date) {
                    bloc.changeDate(date);
                    dateController.text = bloc.dateToString;
                  }, DateTime.now().add(Duration(days: 365)));
                },
                keyboardType: TextInputType.datetime,
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today,
                        color:
                            appService<AppSettings>().appTheme!.primaryColor),
                    hintText: 'AAAA-MM-DD'),
              );
            },
          ))
        ],
      ),
    ),
    Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text('Selecciona tu hora deseada',
                style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          Container(
            child: StreamBuilder(
              stream: bloc.scheduleStream,
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                return TextField(
                  onTap: () {
                    appService<General>().selectTime(context, (TimeOfDay time) {
                      bloc.changeSchedule(time);
                      timeController.text = bloc.scheduleToString;
                    });
                  },
                  keyboardType: TextInputType.datetime,
                  controller: timeController,
                  readOnly: true,
                  decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.access_time,
                          color:
                              appService<AppSettings>().appTheme!.primaryColor),
                      hintText: '12:00'),
                );
              },
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: StreamBuilder(
              stream: bloc.formValidStream,
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: snapshot.hasData && !bloc.loading!
                      ? submit as void Function()
                      : null,
                  child: StreamBuilder(
                    stream: bloc.loadingStream,
                    builder: (BuildContext lctx, AsyncSnapshot sht) {
                      return !sht.hasData || sht.data
                          ? Align(
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation(
                                          appService<AppSettings>()
                                              .appTheme!
                                              .primaryColor))))
                          : Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'ENVIAR SOLICITUD DE CITA',
                                    style: TextStyle(
                                        color: appService<AppSettings>()
                                            .appTheme!
                                            .primaryColor),
                                  ),
                                  Icon(
                                    Icons.message,
                                    color: appService<AppSettings>()
                                        .appTheme!
                                        .primaryColor,
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    ),
  ]);
}
