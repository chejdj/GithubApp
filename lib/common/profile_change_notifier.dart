import 'package:flutter/cupertino.dart';
import 'package:github_app/common/global.dart';
import 'package:github_app/models/index.dart';

//共享状态，状态改变的时候，我们期望该状态的UI组件自动更新
class ProfileChangeNotifier extends ChangeNotifier{
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
      Global.saveProfile();
      super.notifyListeners();
  }
}