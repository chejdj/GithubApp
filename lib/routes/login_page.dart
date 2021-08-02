import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logan/flutter_logan.dart';
import 'package:github_app/common/global.dart';
import 'package:github_app/common/user_model.dart';
import 'package:github_app/generated/l10n.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/network/git.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool pwdShow = false;
  GlobalKey _formKey = GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    _nameController.text = Global.profile.lastLogin ?? '';
    if (_nameController.text.isNotEmpty) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.login)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: S.current.userName,
                    hintText: S.current.userNameOrEmail,
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (v) {
                    return v!.trim().isNotEmpty ? null : S.current.userNameRequired;
                  }),
              TextFormField(
                controller: _pwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                    labelText: S.current.password,
                    hintText: S.current.password,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          pwdShow ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      },
                    )),
                obscureText: !pwdShow,
                validator: (v) {
                  return v!.trim().isNotEmpty ? null : S.current.passwordRequired;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _onLogin,
                    textColor: Colors.white,
                    child: Text(S.current.login),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    if ((_formKey.currentState as FormState).validate()) {
      FlutterLogan.log(Global.LOG_FLAG, 'start Login');
      // showLoading(context);
      User? user;
      try {
        user = await Git(context).login(_nameController.text, _pwdController.text);
        Provider.of<UserModel>(context, listen: false).currentUser = user;
      } catch (e) {
        FlutterLogan.log(Global.LOG_FLAG, 'userLogin failed ${e.toString()}');
      } finally {
        Navigator.of(context).pop();
      }
    }
  }
}
