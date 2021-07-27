import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_app/common/user_model.dart';
import 'package:github_app/generated/l10n.dart';
import 'package:github_app/states/avatar.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context, 
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(),
              Expanded(child: _buildMenus()),
            ],
          )),
    );
  }

  Widget _buildHeader(){
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget? child){
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: value.isLogin ? gmAvatar(value.user!.avatarUrl!, width: 80)
                          : Image.asset("imgs/avatar_default.png",
                      width: 64, height: 64,),
                ),
                ),
                Text(value.isLogin
                    ? value.user!.login!
                    : S.current.login,
                style:TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                )
              ],
            ),
          ),
          onTap: (){
            if(!value.isLogin) Navigator.of(context).pushNamed('login');
          },
        );
      },
    );
  }

  Widget _buildMenus(){
    return Consumer<UserModel>(builder: (context, userModel, child){
       return ListView(
         children: <Widget>[
           ListTile(
             leading: const Icon(Icons.color_lens),
             title: Text(S.current.theme),
             onTap: () => Navigator.pushNamed(context, 'themes'),
           ),
           ListTile(
             leading: const Icon(Icons.language),
             title: Text(S.current.language),
             onTap: () => Navigator.pushNamed(context, 'language'),
           ),
           if(userModel.isLogin) ListTile(
             leading: const Icon(Icons.power_settings_new),
             title: Text(S.current.logout),
             onTap: (){
               showDialog(
                   context: context,
                   builder: (ctx){
                     return AlertDialog(
                       content: Text(S.current.logoutTips),
                       actions: <Widget>[
                         FlatButton(child: Text(S.current.cancel), onPressed: () => Navigator.pop(context),
                         ),
                         FlatButton(child: Text(S.current.yes), onPressed: (){
                            userModel.user = null;
                            Navigator.pop(context);
                         },)
                       ],
                     );
                   },
               );
             },
           )
         ],
       );
    });
  }

}
