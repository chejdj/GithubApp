import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_app/common/user_model.dart';
import 'package:github_app/l10n/gmlocalizations.dart';
import 'package:github_app/models/index.dart';
import 'package:github_app/network/git.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute>{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text(GmLocalizations.of(context)!.home),
       ),
       body: _buildBody(), //构建主页面
       drawer: MyDrawer(),
     );
  }

  Widget _buildBody(){
    UserModel userModel = Provider.of<UserModel>(context);
    if(!userModel.isLogin){
      return Center(
        child: RaisedButton(
          child: Text(GmLocalizations.of(context)!.login),
          onPressed: ()=> Navigator.of(context).pushNamed("login"),
        ),
      );
    }else{
      return InfiniteListView<Repo>(
        onRetrieveData: (int page, List<Repo> items, bool refresh) async{
           var data = await Git(context).getRepos(refresh: refresh, queryParameters:{
             'page': page,
              'page_size': 20,
           });
           items.addAll(data);
           return data.length == 20;
        },
        itemBuilder: (List list, int index, BuildContext ctx){
          return RepoItem(list[index]);
        },
      );
    }
  }
}