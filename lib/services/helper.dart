import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension CachedNetworkImageExtension on CachedNetworkImage {
  static Widget customImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Color? placeholderColor,
    Color? errorColor,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder:
          (context, url) => Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                placeholderColor ?? Colors.blue,
              ),
            ),
          ),
      errorWidget:
          (context, url, error) =>
              Center(child: Icon(Icons.error, color: errorColor ?? Colors.red)),
    );
  }
}

class CustomToast {
  static void show({
    required String message,
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
    int timeInSecForIosWeb = 1,
    Color backgroundColor = Colors.green,
    Color textColor = Colors.white,
    double fontSize = 16.0,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}

