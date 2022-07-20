import 'package:flutter/material.dart';
import 'package:flutter_banckofamerica/components/banner_publicitario_component.dart';
import 'package:flutter_banckofamerica/components/tabs_component.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../utils/utils.dart';

class ListadoScreen extends StatelessWidget {
  ListadoScreen({Key? key}) : super(key: key);
  static String routerName = 'listado';
  late InterstitialAd _interstitialAd;
  bool _isAdLoaded = false;

  @override
  Widget build(BuildContext context) {
    final bankProvider = Provider.of<BankProvider>(context);
    final geolocationProvider = Provider.of<GeolocationProvider>(context);

    String longitud = geolocationProvider.currentPosition.longitude.toString();
    String latitud = geolocationProvider.currentPosition.latitude.toString();
    final size = MediaQuery.of(context).size;
    // String coordenadas = '33.530965, -86.723663';
    String coordenadas = '$latitud,$longitud';
    bankProvider.getListBanks(coordenadas);
    _anuncioIntersticial(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, 'home'),
            icon: const Icon(Icons.home)),
        title: const Text('Banks near me'),
        centerTitle: true,
      ),
      persistentFooterButtons: const [BannerPublicitarioComponent()],
      body: Column(
        children: [
          TabsComponent(
              size: size,
              colorLista: Colors.blue,
              colorMapa: Colors.white,
              colorTexto: Colors.black),
          FutureBuilder(
            future: bankProvider.getListBanks(coordenadas),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                Widget resultado = (bankProvider.listaBancos.isEmpty)
                    ? _MensajeNoExiste(coordenadas: coordenadas)
                    : Expanded(
                        child: ListView.builder(
                          itemCount: bankProvider.listaBancos.length,
                          itemBuilder: (BuildContext context, int index) {
                            String distancia = (bankProvider
                                        .listaBancos[index].distance.length >
                                    3)
                                ? bankProvider.listaBancos[index].distance
                                    .substring(0, 3)
                                : bankProvider.listaBancos[index].distance;
                            return Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12)),
                              child: ListTile(
                                leading: const Icon(Icons.map),
                                trailing: Text('$distancia mi'),
                                title: Text(
                                  bankProvider.listaBancos[index].name,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                subtitle: Text(
                                  bankProvider.listaBancos[index].address,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                onTap: () {
                                  bankProvider.bancoSeleccionado =
                                      bankProvider.listaBancos[index];
                                  _anuncioIntersticial(context);
                                  if (_isAdLoaded) {
                                    _interstitialAd.show();
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      );

                return resultado;
              }
            },
          ),
        ],
      ),
    );
  }

  void _anuncioIntersticial(BuildContext context) {
    InterstitialAd.load(
        adUnitId: VarUtil.interestitialId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
            _isAdLoaded = true;
            _interstitialAd.fullScreenContentCallback =
                FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                _interstitialAd.dispose();
                _isAdLoaded = false;
                Navigator.pushNamed(context, 'detalle');
              },
              onAdFailedToShowFullScreenContent:
                  (InterstitialAd ad, AdError error) {
                // print('$ad onAdFailedToShowFullScreenContent: $error');
                ad.dispose();
              },
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            // print('InterstitialAd failed to load: $error');
          },
        ));
  }
}

class _MensajeNoExiste extends StatelessWidget {
  const _MensajeNoExiste({
    Key? key,
    required this.coordenadas,
  }) : super(key: key);

  final String coordenadas;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          padding: const EdgeInsets.all(8.0),
          width: double.infinity,
          color: Colors.red,
          child: Text(
            'No results found near your location $coordenadas ',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
