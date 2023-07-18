import 'dart:async';

import 'package:easy_wallpapers/easy_wallpapers.dart';
import 'package:example/model/mock_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EasyWallpaperApp(
          wallpaperUrls: data,
          title: 'Wallpapers',
          leadingTitle: 'Nice',
          bannerId: "ca-app-pub-3940256099942544/6300978111",
          bgImage:
              'https://i.pinimg.com/564x/99/83/87/9983876e5771924849c55d19ee7fec5a.jpg',
          placementBuilder: _addPlacements,
          onTapEvent: _onTapEvent,
          onSetOrDownloadWallpaper: _downloadWallpaper,
          isTrendingEnabled: true,
          isCacheEnabled: true,
        ),
      ),

    );
  }

  Widget _addPlacements(BuildContext context, WallpaperPlacement placement) {
    switch (placement) {
      case WallpaperPlacement.wallpaperHomeTop:
        return Container(height: 50, width: double.infinity, color: Colors.red);
      case WallpaperPlacement.wallpaperCategoryTop:
        return Container(
            height: 50, width: double.infinity, color: Colors.orange);
      default:
        return const SizedBox();
    }
  }

  void _onTapEvent(BuildContext context, WallpaperEventAction eventAction) {
    printLog(eventAction.name);
  }

  StreamSubscription? _streamSubscription;

  Future<bool> _downloadWallpaper(BuildContext context) {
    final completer = Completer<bool>();


    return completer.future;
  }

  void printLog(String str) {
    if (kDebugMode) {
      print(str);
    }
  }

  Future<bool?> showRewardedAdAlertDialog(BuildContext context,
      {required VoidCallback onWatchAd, required VoidCallback onClickNo}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final no = TextButton(
          child: const Text("No"),
          onPressed: () {
            Navigator.of(context).pop(false);
            onClickNo();
          },
        );
        final yes = TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onWatchAd.call();
          },
          child: const Text("Watch Ad"),
        );
        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: const Text('Download!'),
          content:
              const Text('Would you like to watch rewarded ad to download?'),
          actions: [no, yes],
        );
        return alert;
      },
    );
  }
}
