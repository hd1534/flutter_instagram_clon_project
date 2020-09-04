import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram Clon",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      ),

      body: _buildBody(),

    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SafeArea(  // 아이폰 노치같은거 때문에 안전하게 보이기 위해서
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text("Instagram에 오신걸 환영합니다.",
                  style: TextStyle(fontSize: 24),),
                Padding(padding: EdgeInsets.all(8.0)),

                Text("사진과 영상을 보려면 팔로우하세요"),
                Padding(padding: EdgeInsets.all(16.0)),

                SizedBox(  // 감싸고 있는 자식 위젯의 크기 조절
                  width: 260,
                  child: Card(
                    child: Column(
                      children: [
                        RaisedButton(
                          child: Text("팔로우"),
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
