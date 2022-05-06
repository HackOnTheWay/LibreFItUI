import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class MLScreen extends StatefulWidget {
  const MLScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _MLScreenState createState() => _MLScreenState();
}

class _MLScreenState extends State<MLScreen> with TickerProviderStateMixin {
  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  File? imageFile;
  String? result = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Food Analyzer",
            textAlign: TextAlign.center,
          ),
        ),
        body: Column(
          children: [
            Container(
              child: imageFile == null
                  ? Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.greenAccent,
                            onPressed: () {
                              _getFromGallery();
                            },
                            child: Text("PICK FROM GALLERY"),
                          ),
                          Container(
                            height: 40.0,
                          ),
                          RaisedButton(
                            color: Colors.lightGreenAccent,
                            onPressed: () {
                              _getFromCamera();
                            },
                            child: Text("PICK FROM CAMERA"),
                          )
                        ],
                      ),
                    )
                  : Container(
                      child: Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            RaisedButton(
              color: Colors.lightGreenAccent,
              onPressed: () {
                Upload(imageFile!);
              },
              child: Text("Analyze"),
            ),
            Text(result!),
          ],
        ),
      ),
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Upload(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse('http://10.100.26.63:5000/api/predict');

    var request = new http.MultipartRequest("POST", uri);
    // var multipartFile = new http.MultipartFile('file', stream, length,
    //     ip_img: 'ip_img');
    request.files.add(new http.MultipartFile('ip_img', stream, length,
        filename: basename(imageFile.path)));
    // print(multipartFile.toString());
    //contentType: new MediaType('image', 'png'));

    //request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      setState(() => result= value);
      print(value);
    });
  }
}
