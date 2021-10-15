import 'package:permission_handler/permission_handler.dart' as phandler;

Future<phandler.PermissionStatus> getStorageStatus() {
  return phandler.Permission.storage.status;
}

Future<phandler.PermissionStatus> requestStoragaStatus() =>
    phandler.Permission.storage.request();

Future<bool> getStorageGranted() =>
    phandler.Permission.storage.request().isGranted;
