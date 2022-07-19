import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

//Colores
const colorPrincipal = Colors.blue;
const colorNaranja = Color(0xffFF9A3B);

//Imagenes
const imgLoading = 'assets/images/loading.gif';
const imgBanner = 'assets/images/banner.png';
const imgLogo = 'assets/images/logo-Bank-of-America.png';

//Iconos
// const icoNosotros = 'assets/icons/about.png';

class DefaultTheme {
  static ThemeData base = ThemeData.light().copyWith(
    primaryColor: colorPrincipal,
    appBarTheme: const AppBarTheme(color: colorPrincipal),
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.black, fontSize: 10),
      bodyText2: TextStyle(color: Colors.black),
      //headline1: GoogleFonts.akayaTelivigala(fontSize: 60, color: Colors.white, fontWeight: FontWeight.bold)
    ), //TextTheme
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: colorPrincipal),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      primary: colorPrincipal,
      shape: const StadiumBorder(),
    )),
  );
}

BoxDecoration fondoScreen(String fondo) {
  return BoxDecoration(
    image: DecorationImage(image: AssetImage(fondo), fit: BoxFit.fill),
  );
}

BoxDecoration boxBoton(color) {
  return BoxDecoration(
    color: color,
    border: Border.all(color: Colors.white, width: 2.5),
    borderRadius: BorderRadius.circular(20),
  );
}

BoxDecoration boxRecuadro(color, double radio) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radio),
  );
}

BoxDecoration boxRecuadroOnly(
    color, double arribaI, double arribaD, double abajoI, double abajoD) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(arribaI),
        topRight: Radius.circular(arribaD),
        bottomLeft: Radius.circular(abajoI),
        bottomRight: Radius.circular(abajoD)),
  );
}

BoxDecoration boxRecuadroSombra(color, double radio) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radio),
      boxShadow: [
        BoxShadow(color: Colors.black12, offset: Offset(0, 5), blurRadius: 5)
      ]);
}
