import 'package:cached_network_image/cached_network_image.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/custom_bot_toast.dart';
import 'package:flutter/material.dart';

import 'loading_indicator.dart';

Widget loadImage(
  String? linkGambar, {
  bool isShowLoading = true,
  Alignment alignment = Alignment.center,
  bool hasErrorWidget = true,
  Color /*?*/ /*!*/ /*?*/ /*?*/ ? color,
  BoxFit boxFit = BoxFit.cover,
  double? width,
  double? height,
}) {
  if (linkGambar == null || linkGambar.isEmpty) {
    return Icon(Icons.error_outline);
  } else {
    try {
      Widget image = CachedNetworkImage(
        fit: boxFit,
        color: color!,
        height: height!,
        width: width!,
        imageUrl: Uri.encodeFull('$linkGambar'),
        alignment: alignment,
        placeholder: (context, url) {
          if (isShowLoading) {
            return loadingIndicator(color: Theme.of(context).accentColor);
          } else {
            return Container();
          }
        },
        errorWidget: (context, url, error) =>
            !hasErrorWidget ? Container() : Icon(Icons.error_outline),
      );
      return image;
    } catch (e) {
      customBotToastText(ErrorMessage.general);
      return Icon(Icons.error_outline);
    }
  }
}
