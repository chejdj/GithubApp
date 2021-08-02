import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logan/flutter_logan.dart';
import 'package:github_app/common/global.dart';
import 'package:github_app/common/theme_model.dart';
import 'package:github_app/generated/l10n.dart';
import 'package:provider/provider.dart';

class ThemeChangeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.theme),
      ),
      body: ListView(
        children: Global.themes.map<Widget>((e) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Container(
                color: e,
                height: 40,
              ),
            ),
            onTap: () {
              Provider.of<ThemeModel>(context).theme = e;
              FlutterLogan.log(Global.LOG_FLAG, 'change theme');
            },
          );
        }).toList(),
      ),
    );
  }
}
