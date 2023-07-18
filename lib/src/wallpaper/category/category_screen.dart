import 'package:easy_wallpapers/src/easy_wallpaper_controller.dart';
import 'package:easy_wallpapers/src/models/enums.dart';
import 'package:easy_wallpapers/src/utilities/network_manager.dart';
import 'package:easy_wallpapers/src/wallpaper/components/wallpaper_listing.dart';
import 'package:easy_wallpapers/src/widgets/banner_widget.dart';
import 'package:easy_wallpapers/src/widgets/header_text.dart';
import 'package:easy_wallpapers/src/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = "/categoryScreen";
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = EasyWallpaperController.of(context);

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
        controller.bgImage!
      ),fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: Colors.black),
          title: HomeHeaderText(
              leadingText: controller.leadingTitle, name: controller.title,),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    if (controller.placementBuilder != null)
                      controller.placementBuilder!.call(
                          context, WallpaperPlacement.wallpaperCategoryTop),
                    const VerticalSpacing(),
                    _fetchTrendingWallpapers(context, widget.category),
                    const VerticalSpacing(),
                  ],
                ),
              ),
            ),
            BannerWidget(
                adSize: AdSize.banner,
                bannerId: EasyWallpaperController.of(context).admobBanner!)
          ],
        ),
      ),
    );
  }

  List myWallPaper = [];
  Widget _fetchTrendingWallpapers(BuildContext context, String category) {
    final wallpapers = NetworkManager.getWallpapersByCategory(
            category, EasyWallpaperController.of(context).wallpaperUrls) ??
        [];
    myWallPaper = wallpapers;
    return WallpaperListing(wallpapers, _scrollController);
  }
}
