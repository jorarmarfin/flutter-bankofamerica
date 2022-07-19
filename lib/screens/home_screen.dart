import 'package:flutter/material.dart';

import 'package:flutter_banckofamerica/themes/default_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routerName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Image(image: AssetImage(imgBanner)),
          const SizedBox(
            height: 40,
          ),
          const Image(image: AssetImage(imgLogo), width: 200),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'listado');
              },
              child: const Text('Search Now!'))
        ],
      ),
    );
  }
}
