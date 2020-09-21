import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreatePage extends StatefulWidget {
  final User user;

  CreatePage(this.user);

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
          child: Icon(Icons.add_a_photo), onPressed: _getImage),
    );
  }

  _buildAppBar() {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            final firebaseStorageRef = FirebaseStorage.instance
                .ref()
                .child('post')
                .child("${DateTime.now().millisecondsSinceEpoch}.png");

            final task = firebaseStorageRef.putFile(
              _image, StorageMetadata(contentType: 'image/png')
            );

            task.onComplete.then((value) {
              value.ref.getDownloadURL().then((uri) {
                var doc = FirebaseFirestore.instance.collection("post").doc();
                doc.set({
                  "id" : doc.id,
                  "photoURL": uri.toString(),
                  'contents': textEditingController.text,
                  'writer': {
                    "name": widget.user.displayName,
                    "email": widget.user.email,
                    "photoURL": widget.user.photoURL
                  }
                }).then((value) {
                  Navigator.pop(context);
                });
              });
            });
          },
        )
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      // 공간이 부족시 스크롤 되게 (안하면 공간 부족시 에러)
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
