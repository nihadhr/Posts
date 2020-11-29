import 'package:flutter/material.dart';


class Banner extends StatefulWidget {
  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BannerDemo(

      ),

    );
  }
}

enum BannerAction{
  showLeading,
  showMultiple,
  reset
}

class BannerDemo extends StatefulWidget {
  @override
  _BannerDemoState createState() => _BannerDemoState();
}

class _BannerDemoState extends State<BannerDemo> {
  var _showLeading=true; var _showMultiple=true; var _displayBanner=true;

  void handleAction(BannerAction action){
    switch(action){
      case BannerAction.reset:
        setState(() {
          _showLeading=true; _showMultiple=true; _displayBanner=true;
        }); break;
      case BannerAction.showLeading:
        setState(() {
          _showLeading = !_showLeading;
        }); break;

      case BannerAction.showMultiple:
        setState(() {
          _showMultiple = !_showMultiple;
        }); break;
    }

  }

  @override
  Widget build(BuildContext context) {
    var myBanner=MaterialBanner(
      content:Text('In order to continue You need to Sign in'),
      leading: _showLeading? CircleAvatar(child:Icon(Icons.login)):null,

      actions: [
        FlatButton(child:Text('Sign in', style: TextStyle(color: Colors.purple),),
          onPressed: (){
            setState(() {
              _displayBanner=false;
            });
          },
        ),
        if(_showMultiple)
          FlatButton(child:Text('Dismiss', style: TextStyle(color: Colors.purple),),
            onPressed: (){
              setState(() {
                _displayBanner=false;
              });
            },
          ),

      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Home panel'),
        backgroundColor: Colors.red,
        actions: [
          PopupMenuButton<BannerAction>(
            onSelected: handleAction,
            itemBuilder: (context)=>
            <PopupMenuEntry<BannerAction>>[
              PopupMenuItem<BannerAction>(value: BannerAction.reset,child:Text('Reset')),
              const PopupMenuDivider(),
              CheckedPopupMenuItem<BannerAction>(value: BannerAction.showMultiple,
                child:Text('Show multiple'),
                checked: _showMultiple,

              ),
              CheckedPopupMenuItem<BannerAction>(value: BannerAction.showLeading,
                child:Text('Show leading'),
                checked: _showLeading,
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: _displayBanner? myBanner:null,

      ),
    );
  }
}

