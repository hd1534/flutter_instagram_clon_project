import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final textEditingController = TextEditingController();

  final picker = ImagePicker();
  File _image;

  @override
  void dispose() {
    // 소멸될때 실행
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 생성될때 실행
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: _getImage
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {},
        )
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(  // 공간이 부족시 스크롤 되게 (안하면 공간 부족시 에러)
      child: Column(
        children: [
          _image == null ? Text("No Image") : Image.file(_image),
          TextField(
            decoration: InputDecoration(hintText: "내용을 입력하세요"),
            controller: textEditingController,
          )
        ],
      ),
    );
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
}
