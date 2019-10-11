import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

class FirstRouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Center(
        child: new Column(
          children: <Widget>[
            TextField(

            ),
            SizedBox(
              height: 0.2,
              child: Container(
                color: Colors.black,
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_a_photo),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text(
                "长列表",
                style: TextStyle(fontSize: 20,color: Colors.red,fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,

              ),
              onTap: (){
                //点击返回到原生页面
                FlutterBoost.singleton.open("sample://listDetail");
//                FlutterBoost.singleton.close("sample://firstPage");
//                Navigator.push(context, new MaterialPageRoute(builder: (context) => new SecondRouteWidget()));
              },
            )
          ],
        ),

      ),

    );
  }
}