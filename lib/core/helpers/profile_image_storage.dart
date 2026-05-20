import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'shared_pref_helper.dart';
import 'shared_prefs_keys.dart';

class ProfileImageStorage {
  ProfileImageStorage._();

  static final ValueNotifier<String?> imagePathNotifier = ValueNotifier(null);
  static final ValueNotifier<int> imageGeneration = ValueNotifier(0);
  static const String _fileName = 'profile_avatar.jpg';

  static Future<File> _localAvatarFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  static Future<void> init() async {
    final savedPath = SharedPrefHelper.getString(SharedPrefsKeys.profileImagePath);
    if (savedPath.isNotEmpty && File(savedPath).existsSync()) {
      imagePathNotifier.value = savedPath;
      return;
    }

    final localFile = await _localAvatarFile();
    if (localFile.existsSync()) {
      imagePathNotifier.value = localFile.path;
      await SharedPrefHelper.setString(
        SharedPrefsKeys.profileImagePath,
        localFile.path,
      );
    }
  }

  static Future<bool> savePickedImage(XFile picked) async {
    final destination = await _localAvatarFile();
    final bytes = await picked.readAsBytes();
    await destination.writeAsBytes(bytes, flush: true);

    await SharedPrefHelper.setString(
      SharedPrefsKeys.profileImagePath,
      destination.path,
    );

    PaintingBinding.instance.imageCache.evict(FileImage(destination));
    imagePathNotifier.value = null;
    imagePathNotifier.value = destination.path;
    imageGeneration.value++;

    return true;
  }

  // static Future<void> clear() async {
  //   final path = imagePathNotifier.value ??
  //       SharedPrefHelper.getString(SharedPrefsKeys.profileImagePath);
  //   if (path.isNotEmpty) {
  //     final file = File(path);
  //     if (file.existsSync()) await file.delete();
  //   }
  //   await SharedPrefHelper.setString(SharedPrefsKeys.profileImagePath, '');
  //   imagePathNotifier.value = null;
  // }
}
