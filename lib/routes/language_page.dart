import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_app/common/locale_model.dart';
import 'package:github_app/generated/l10n.dart';
import 'package:lingoace_component_log/llog.dart';
import 'package:provider/provider.dart';

class LanguageRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     var color = Theme.of(context).primaryColor;
     var localModel = Provider.of<LocaleModel>(context);

     Widget _buildLanguageItem(String lan, value){
       return ListTile(
         title: Text(
           lan,
           style: TextStyle(color: localModel.getLocale() == value ? color : null),
         ),
         trailing:
         localModel.getLocale() == value ? Icon(Icons.done, color: color) : null,
         onTap: (){
           LLog.i('change local: $value');
           localModel.locale = value;
       },
       );
     }

     return Scaffold(
       appBar: AppBar(
         title: Text(S.current.language),
       ),
       body: ListView(
         children: <Widget>[
           _buildLanguageItem("中文简体", "zh_CN"),
           _buildLanguageItem("English", "en_US"),
           _buildLanguageItem(S.current.auto, null),
         ],
       ),
     );
  }
}