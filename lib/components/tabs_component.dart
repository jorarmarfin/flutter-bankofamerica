import 'package:flutter/material.dart';

class TabsComponent extends StatelessWidget {
  const TabsComponent({
    Key? key,
    required this.size,
    required this.colorMapa,
    required this.colorLista,
    required this.colorTexto,
  }) : super(key: key);

  final Size size;
  final Color colorMapa;
  final Color colorLista;
  final Color colorTexto;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                      color: colorLista, style: BorderStyle.solid, width: 2))),
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'listado');
            },
            minWidth: size.width * 0.5,
            child: Text(
              'LIST',
              style: TextStyle(color: colorTexto),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                      color: colorMapa, style: BorderStyle.solid, width: 2))),
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'mapa');
            },
            minWidth: size.width * 0.5,
            child: Text(
              'MAP',
              style: TextStyle(color: colorTexto),
            ),
          ),
        ),
      ],
    );
  }
}
