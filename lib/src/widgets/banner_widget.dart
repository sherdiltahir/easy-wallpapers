import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key, required this.adSize, required this.bannerId});
 final  AdSize adSize;
 final String bannerId;
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  bool isBannerLoaded = false;
  late BannerAd bannerAd;

  void _initBannerAdMobAds() {
    bannerAd = BannerAd(
        size: widget.adSize,
        adUnitId: widget.bannerId,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isBannerLoaded = true;
          });
        }, onAdFailedToLoad: (Ad ad, LoadAdError loadAdError) {
          setState(() {
            isBannerLoaded = false;
          });
        },),
        request: const AdRequest(),);
    bannerAd.load();
  }

  @override
  void initState() {
    _initBannerAdMobAds();
    super.initState();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isBannerLoaded
          ? SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: AdWidget(
                ad: bannerAd,
              ),
            )
          : const SizedBox()
    ;
  }
}
