import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static final SharedPreferenceHelper _instance =
  SharedPreferenceHelper._internal();

  factory SharedPreferenceHelper() => _instance;

  SharedPreferences? _preferences;

  SharedPreferenceHelper._internal();

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getEmail() {
    return _preferences?.getString('userEmail');
  }

  Future<String?> retrieveImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('imagePath');
  }

  String? getUserName() {
    return _preferences?.getString('userName');
  }




}