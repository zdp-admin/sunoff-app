import 'package:flutter/material.dart';
import 'package:sunoff/models/cotizacion/cotizacion_model.dart';
import 'package:sunoff/models/cotizacion/seccion_modelo.dart';

class MeasuresDetails extends StatefulWidget {
  late final CotizacionModel cotization;
  MeasuresDetails({required this.cotization});

  @override
  State<MeasuresDetails> createState() => _MeasuresDetailsState();
}

class _MeasuresDetailsState extends State<MeasuresDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles Internos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Container(
                    padding: EdgeInsets.all(25), child: Text('Secciones'))),
            Column(
              children: this
                  .widget
                  .cotization
                  .secciones
                  .map((e) => _seccion(e))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Container _seccion(SeccionModelo e) {
    return Container(
      decoration: BoxDecoration(color: Colors.black12),
      child: Column(
        children: [
          Container(child: Text('${e.nombre}')),
          Container(
            child: Column(
              children: e.medidas
                  .map((e) => Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${e.ancho.toString()} x ${e.alto.toString()}'),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
