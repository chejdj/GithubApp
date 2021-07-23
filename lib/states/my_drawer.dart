import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_app/common/user_model.dart';

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
    )
  }
}
