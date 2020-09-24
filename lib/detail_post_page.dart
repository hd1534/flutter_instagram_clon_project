import 'package:flutter/material.dart';

class DetailPostPage extends StatelessWidget {
  final dynamic document;


  DetailPostPage(this.document);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("둘러보기"),
      ),

      body: _buildBody(),
    );
  }

  _buildBody() {
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          document.get('writer')['photoURL']),
                    )
                  ],
                ),),


            ],
          ),
        )
    );
  }
}
