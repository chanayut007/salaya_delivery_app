
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salaya_delivery_app/core/constants/value_constant.dart';

class PdfApi {

  static Future<String> saveDocument({
    required String name,
    required Document pdf
  }) async {
    final bytes = await pdf.save();

    Directory? directory = await getExternalStorageDirectory();
    // output => /storage/emulated/0/Android/data/-- Application --/files

    String newPath = "";
    List<String> folders = directory!.path.split("/");
    for (int i = 1; i < folders.length; i++) {
      String folder = folders[i];
      if (folder != "Android") {
        newPath += "/$folder";
      } else {
        break;
      }
    }

    newPath = newPath + "/${ValueConstant.directory}";
    directory = Directory(newPath);
    print(directory.path);

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final file = File('${directory.path}/$name');

    await file.writeAsBytes(bytes);

    debugPrint("pdf file path: ${file.path}");

    return file.path;
  }

  static Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

}