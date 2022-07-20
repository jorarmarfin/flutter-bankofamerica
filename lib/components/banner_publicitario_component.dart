import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/utils.dart';

class BannerPublicitarioComponent extends StatelessWidget {
  const BannerPublicitarioComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BannerAd myBanner = BannerAd(
      adUnitId: VarUtil.bannerId,
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    myBanner.load();
    final AdWidget adWidget = AdWidget(ad: myBanner);
    return Container(
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
      color: Colors.white,
      child: adWidget,
    );
  }
}
