import '../../utiles/socket_service.dart';

class AppRepository {
  static AppRepository? _instance;

  factory AppRepository() {
    _instance ??= AppRepository._internal();
    return _instance!;
  }
  AppRepository._internal();

  Future<bool> checkUserStatus() async {
  return true;
  }


}
