import 'package:flutter/material.dart';
import 'package:flutter_banckofamerica/providers/providers.dart';
import 'package:flutter_banckofamerica/screens/screens.dart';
import 'package:flutter_banckofamerica/themes/default_theme.dart';

import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => UtilsProvider(),
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
        HomeScreen.routerName: (context) => HomeScreen(),
        MapaScreen.routerName: (context) => const MapaScreen(),
        ListadoScreen.routerName: (context) =>  ListadoScreen(),
        DetalleScreen.routerName: (context) => const DetalleScreen(),
      },
      theme: DefaultTheme.base,
    );
  }
}
