import 'dart:async';

import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/data/models/auth/login/post_login.dart';
import 'package:ecommerce_app/data/models/auth/user/user_data.dart';
import 'package:ecommerce_app/data/models/auth/users/UsersModel.dart';
import 'package:ecommerce_app/data/remote_data/response_model.dart';
import 'package:ecommerce_app/features/auth/domain/cases/auth_case.dart';
import 'package:ecommerce_app/res/loading/loading_overlay_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom_mixin/mixen_widgets/status_error.dart';

class MainGetxController extends GetxController {
  StatusError statusError = StatusError();
  Timer? t;

  late LoadingGetxController loadingGetxController;

  bool get isLogin => false;
  
UserData? get user => UserData();

final response= sl<AuthCases>().userInfo();

@override
  void onInit() {
    super.onInit();
    loadingGetxController = Get.put(LoadingGetxController());
     loadTheme();

  }

  //themes

  bool isDark = false;

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool('isDark') ?? false;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    update();
  }

  void toggleTheme(bool value) async {
    isDark = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    update();
  }


  customDebounce(
      {Duration duration = const Duration(milliseconds: 500),
      required Function() getData}) {
    if (t == null) {
      sPrint.info('timer:: t == null');
      t = Timer(duration, () {
        getData();
      });
    } else if (t!.isActive) {
      sPrint.info('timer:: t!.isActive');
      t!.cancel();
      t = Timer(duration, () {
        getData();
      });
    } else {
      sPrint.info('timer:: else');
      t!.cancel();
      t = Timer(duration, () {
        getData();
      });
    }
  }
}

enum LoadingType { show, hide, error, progress, loadingIcon }

class LoadingGetxController extends GetxController {
  LoadingType loadingType = LoadingType.hide;

  String progress = '0.0 %';

  bool get isLoading =>
      loadingType != LoadingType.hide || loadingType != LoadingType.error;

  setProgress(String progress) {
    this.progress = progress;
    update([loadingID]);
  }

  showProgress() {
    loadingType = LoadingType.progress;
    update([loadingID]);
  }

  showLoadingIcon() {
    loadingType = LoadingType.loadingIcon;
    update([loadingIconID]);
  }

  showLoading() {
    sPrint.info('start loading');
    loadingType = LoadingType.show;
    update([loadingID]);
  }

  showCustomLoading(String id) {
    sPrint.info('start loading');
    loadingType = LoadingType.show;
    update([id]);
  }

  hideCustomLoading(String id) {
    sPrint.info('end loading');
    loadingType = LoadingType.hide;
    update([loadingID, loadingIconID, id]);
  }

  Future hideLoading() async {
    sPrint.info('end loading');
    loadingType = LoadingType.hide;
    update([loadingID, loadingIconID]);
  }

  showError() {
    sPrint.info('show error');
    loadingType = LoadingType.error;
    update([loadingID, loadingIconID]);
  }
}
