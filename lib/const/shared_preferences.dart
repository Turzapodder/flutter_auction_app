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

  String? getBalance() {
    return _preferences?.getString('userBal');
  }

  Future<void> saveUserName(String? name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name!);
  }

  Future<void> saveEmail(String? email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email!);
  }

  Future<void> saveBalance(String balance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isBalanceSet = prefs.containsKey("balance");
    if (!isBalanceSet) {
      prefs.setString("userBal", balance);
    }
  }




}