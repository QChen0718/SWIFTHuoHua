import 'package:flutter/material.dart';

class TestClick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("测试页面"),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Text("label",style: TextStyle(fontSize: 20,color: Colors.red),textAlign: TextAlign.end,),
            new TextField(keyboardType: TextInputType.number,
              onChanged: (value){
                print("文字提交触发");
              },
              decoration: new InputDecoration(
                labelText: "请输入内容"
              ),
            ),
            new TextField(keyboardType: TextInputType.text,)
          ],
        )

      ),
    );
  }
}