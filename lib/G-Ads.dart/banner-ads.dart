// import 'dart:html';
// import 'dart:io';

import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdController extends GetxController {
  AdmobInterstitial? interstitialAd;
  AdmobReward? rewardAd;
  AdmobBannerSize? bannerSize;

  @override
  void onInit() {
    super.onInit();
    bannerSize = AdmobBannerSize.BANNER;
    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId()!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd!.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    rewardAd = AdmobReward(
      adUnitId: getRewardBasedVideoAdUnitId()!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) rewardAd!.load();
        handleEvent(event, args, 'Reward');
      },
    );
    interstitialAd!.load();
    rewardAd!.load();
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        Get.snackbar('Admob $adType Ad loaded!', '');
        break;
      case AdmobAdEvent.opened:
        Get.snackbar('Admob $adType Ad opened!', '');
        break;
      case AdmobAdEvent.closed:
        Get.snackbar('Admob $adType Ad closed!', '');
        break;
      case AdmobAdEvent.failedToLoad:
        Get.snackbar('Admob $adType failed to load. :(', '');
        break;
      case AdmobAdEvent.rewarded:
        Get.dialog(
          AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Reward callback fired. Thanks Andrew!'),
                Text('Type: ${args!['type']}'),
                Text('Amount: ${args['amount']}'),
              ],
            ),
          ),
        );
        break;
      default:
    }
  }

  @override
  void onClose() {
    interstitialAd!.dispose();
    rewardAd!.dispose();
    super.onClose();
  }

  String? getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }

  String? getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    return null;
  }

  String? getRewardBasedVideoAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    return null;
  }
}
