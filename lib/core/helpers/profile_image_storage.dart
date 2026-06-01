import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'shared_pref_helper.dart';
import 'shared_prefs_keys.dart';

class ProfileImageStorage {
  ProfileImageStorage._();

  static const String _fileName = 'profile_avatar.jpg';

  static final ValueNotifier<({String? path, int version})> imageNotifier =
  ValueNotifier((path: null, version: 0));

  static Future<File> _localAvatarFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  static Future<void> init() async {
    final savedPath =
    SharedPrefHelper.getString(SharedPrefsKeys.profileImagePath);

    if (savedPath.isNotEmpty && File(savedPath).existsSync()) {
      imageNotifier.value = (path: savedPath, version: 0);
      return;
    }

    final localFile = await _localAvatarFile();
    if (localFile.existsSync()) {
      await SharedPrefHelper.setString(
        SharedPrefsKeys.profileImagePath,
        localFile.path,
      );
      imageNotifier.value = (path: localFile.path, version: 0);
    }
  }

  static Future<bool> savePickedImage(XFile picked) async {
    try {
      final destination = await _localAvatarFile();
      final bytes = await picked.readAsBytes();
      await destination.writeAsBytes(bytes, flush: true);

      await SharedPrefHelper.setString(
        SharedPrefsKeys.profileImagePath,
        destination.path,
      );
      // remove old image from cache
      PaintingBinding.instance.imageCache.evict(FileImage(destination));
      // update image notifier
      imageNotifier.value = (
      path: destination.path,
      version: imageNotifier.value.version + 1,
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> clear() async {
    final path = imageNotifier.value.path ??
        SharedPrefHelper.getString(SharedPrefsKeys.profileImagePath);

    if (path.isNotEmpty) {
      final file = File(path);
      if (file.existsSync()) await file.delete();
    }

    await SharedPrefHelper.setString(SharedPrefsKeys.profileImagePath, '');
    imageNotifier.value = (path: null, version: 0);
  }
}
