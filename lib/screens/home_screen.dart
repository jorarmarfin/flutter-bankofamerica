import 'package:flutter/material.dart';
import 'package:flutter_banckofamerica/components/components.dart';

import 'package:flutter_banckofamerica/themes/default_theme.dart';
import 'package:flutter_banckofamerica/utils/utils.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static String routerName = 'home';
  late InterstitialAd _interstitialAd;
  bool _isAdLoaded = false;
  @override
  Widget build(BuildContext context) {
    _anuncioIntersticial(context);
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
                if (_isAdLoaded) {
                  _interstitialAd.show();
                }
              },
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Search Now!',
                    style: TextStyle(fontSize: 25),
                  ))),
          const Expanded(child: SizedBox()),
          const BannerPublicitarioComponent()
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
                Navigator.pop(context);
                Navigator.pushNamed(context, 'listado');
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
