import 'package:github_app/common/global.dart';
import 'package:github_app/models/index.dart';

import 'profile_change_notifier.dart';

class UserModel extends ProfileChangeNotifier{
  User? user = Global.profile.user;
  // ignore: unnecessary_null_comparison
  bool get isLogin => user != null;
  set currentUser(User currentUser){
    if(user?.login != Global.profile.user?.login){
       Global.profile.lastLogin = Global.profile.user?.login;
       Global.profile.user = currentUser;
       notifyListeners();
    }
  }
}