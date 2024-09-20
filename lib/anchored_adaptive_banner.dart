import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AnchoredAdaptiveBanner extends StatefulWidget {
  @override
  _AnchoredAdaptiveBannerState createState() => _AnchoredAdaptiveBannerState();
}

class _AnchoredAdaptiveBannerState extends State<AnchoredAdaptiveBanner> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _loadAd() async {
    final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-1400339910447024/7424405589' // Android için AdMob Banner Reklam Birimi Kimliği
          : 'ca-app-pub-1400339910447024/7424405589', // iOS için AdMob Banner Reklam Birimi Kimliği
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return _anchoredAdaptiveAd != null && _isLoaded
        ? Container(
      color: Colors.green,
      width: _anchoredAdaptiveAd!.size.width.toDouble(),
      height: _anchoredAdaptiveAd!.size.height.toDouble(),
      child: AdWidget(ad: _anchoredAdaptiveAd!),
    )
        : Container();
  }

  @override
  void dispose() {
    super.dispose();
    _anchoredAdaptiveAd?.dispose();
  }
}
