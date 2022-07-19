import 'package:flutter/material.dart';
import 'package:flutter_banckofamerica/providers/providers.dart';
import 'package:flutter_banckofamerica/screens/screens.dart';
import 'package:flutter_banckofamerica/themes/default_theme.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => BankProvider(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => GeolocationProvider(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BankOfAmerica',
      initialRoute: HomeScreen.routerName,
      routes: {
        HomeScreen.routerName: (context) => const HomeScreen(),
        MapaScreen.routerName: (context) => const MapaScreen(),
        ListadoScreen.routerName: (context) => const ListadoScreen(),
        DetalleScreen.routerName: (context) => const DetalleScreen(),
      },
      theme: DefaultTheme.base,
    );
  }
}
