import 'package:easy_wallpapers/src/easy_wallpaper_controller.dart';
import 'package:easy_wallpapers/src/utilities/prefs.dart';
import 'package:easy_wallpapers/src/wallpaper/components/wallpaper_listing.dart';
import 'package:easy_wallpapers/src/widgets/background_widget.dart';
import 'package:easy_wallpapers/src/widgets/banner_widget.dart';
import 'package:easy_wallpapers/src/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class FavoriteWallpapersScreen extends StatefulWidget {
  static const String routeName = "/FavoriteWallpapersScreen";

  const FavoriteWallpapersScreen({super.key});

  @override
  State<FavoriteWallpapersScreen> createState() =>
      _FavoriteWallpapersScreenState();
}

class _FavoriteWallpapersScreenState extends State<FavoriteWallpapersScreen> {
  final ScrollController _scrollController = ScrollController();
  List<String> favWallpapers = Prefs.instance.getFavWallpapers();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: BlurBackgroundWidget(child: Column(
        children: [
          Expanded(child: _buildBody()),
          BannerWidget(adSize: AdSize.banner, bannerId: EasyWallpaperController.of(context).admobBanner!)

        ],
      )),
    );
  }

  AppBar _buildAppBar() {
    final theme = Theme.of(context);
    return AppBar(
      iconTheme: IconThemeData(color: theme.secondaryHeaderColor),
      title: const Text("Favorites"),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildBody() {
    if (favWallpapers.isEmpty) {
      return Center(
          child: Text(
        'There are no favourite\nwallpapers yet',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: Colors.white),
      ));
    }
    return Column(
      children: [
        SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 60),
                WallpaperListing(
                  favWallpapers,
                  _scrollController,
                  onPopFullScreen: onPopFullScreen,
                ),
                const VerticalSpacing(),
              ],
            )),
      ],
    );
  }

  void onPopFullScreen() {
    final updatedWalls = Prefs.instance.getFavWallpapers();
    if (updatedWalls.length == favWallpapers.length) return;

    setState(() => favWallpapers = updatedWalls);
  }
}
