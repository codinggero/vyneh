import 'package:flutter/material.dart';
import '/package.dart';

  Color hexColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

class Appbar {
  static PreferredSizeWidget? appBar(
    BuildContext context, {
    required String title,
    required List<String> tabTitle,
    required List<String> assetName,
  }) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      elevation: 5,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom: TabBar(
        labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        labelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.white,
        unselectedLabelColor: Colors.black45,
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(assetName[0])).p(5),
                const SizedBox(width: 5),
                Text(
                  tabTitle[0],
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ).pOnly(bottom: 12),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(assetName[1])).p(5),
                const SizedBox(width: 5),
                Text(
                  tabTitle[1],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  static PreferredSizeWidget appbar(
    BuildContext context, {
    double? height,
    double? top,
    EdgeInsetsGeometry? padding,
    Color? color = Colors.transparent,
    Widget? child,
    void Function()? onPressed,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        height ?? MediaQuery.of(context).padding.top + 100,
      ),
      child: Container(
        margin: EdgeInsets.only(top: top ?? MediaQuery.of(context).padding.top),
        color: color,
        child: child ??
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: padding ?? const EdgeInsets.all(16),
                  child: OutlinedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Icon(Icons.arrow_back),
                  ),
                )
              ],
            ),
      ),
    );
  }
}
