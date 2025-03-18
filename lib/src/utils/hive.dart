import 'package:hive/hive.dart';
import 'constants.dart';

class AppHive {
  static const String _TOKEN = "token";
  static const String _ISAUTHENTICATED = "isAuthenticated";
  static const String _ISLOGGEDIN = "isLoggedIn";
  static const String _USERID = "userId";
  static const String _USERPROFILEIMAGE = "userProfileImage";
  static const String _USERPROFILENAME = "userProfileName";
  static const String _USERPROFILEEMAIL = "userProfileEmail";
  static const String _ACCOUNTCREATEDTIME = "accountCreatedTime";
  static const String _CURRENTCURRENCY = "currentCurrency";
  static const String _CURRENCYVALUE= "currencyValue";


  Future<void> putIsAuthenticated({required bool isAuthenticated}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _ISAUTHENTICATED,
      isAuthenticated,
    );
  }

  bool getIsAuthenticated() {
    return Hive.box(Constants.BOX_NAME).get(_ISAUTHENTICATED)?? false;
  }

  Future<void> putIsLoggedIn({required bool isLoggedIn}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _ISLOGGEDIN,
      isLoggedIn,
    );
  }

  bool getIsLoggedIn() {
    return Hive.box(Constants.BOX_NAME).get(_ISLOGGEDIN)?? false;
  }

  Future<void> putUserId({required String userId}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _USERID,
      userId,
    );
  }

  String? getUserId() {
    return Hive.box(Constants.BOX_NAME).get(_USERID);
  }

  Future<void> putUserProfileImage({required String imageUrl}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _USERPROFILEIMAGE,
      imageUrl,
    );
  }

  String? getUserProfileImage() {
    return Hive.box(Constants.BOX_NAME).get(_USERPROFILEIMAGE);
  }

  Future<void> putUserProfileEmail({required String userEmail}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _USERPROFILEEMAIL,
      userEmail,
    );
  }

  String? getUserProfileEmail() {
    return Hive.box(Constants.BOX_NAME).get(_USERPROFILEEMAIL);
  }

  Future<void> putUserProfileName({required String userProfileName}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _USERPROFILENAME,
      userProfileName,
    );
  }

  String? getUserProfileName() {
    return Hive.box(Constants.BOX_NAME).get(_USERPROFILENAME);
  }

  Future<void> putAccountCreatedTime({required DateTime accountCreatedTime}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _ACCOUNTCREATEDTIME,
      accountCreatedTime,
    );
  }

  DateTime? getAccountCreatedTime() {
    return Hive.box(Constants.BOX_NAME).get(_ACCOUNTCREATEDTIME);
  }


  Future<void> putCurrentCurrency({required String currentCurrency}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _CURRENTCURRENCY,
      currentCurrency,
    );
  }

  String? getCurrentCurrency() {
    return Hive.box(Constants.BOX_NAME).get(_CURRENTCURRENCY);
  }




  Future<void> putCurrentCurrencyValue({required double currentCurrencyValue}) async {
    await Hive.box(Constants.BOX_NAME).put(
      _CURRENCYVALUE,
      currentCurrencyValue,
    );
  }

  double? getCurrentCurrencyValue() {
    return Hive.box(Constants.BOX_NAME).get(_CURRENCYVALUE);
  }

  void clearHive() {
    Hive.box(Constants.BOX_NAME).clear();
  }

  AppHive();
}
