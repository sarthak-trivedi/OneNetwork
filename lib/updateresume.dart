import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:login_page/userprofile.dart';
class UpdateResume extends StatefulWidget {
  @override
  _UpdateResumeState createState() => _UpdateResumeState();
}

class _UpdateResumeState extends State<UpdateResume> {


  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Text('Update Ressume',textAlign: TextAlign.center,),
        children: <Widget>[
          Container(
            height: 35.0,
            width: 35.0,
            margin: EdgeInsets.only(left: 65.0,right: 65.0),
            color: Colors.blue,
            child: FlatButton(
                onPressed: ()=>_getFile(context),
                child: Text('Upload',style: TextStyle(color: Colors.white),),
            ),
          ),
          FlatButton(
          onPressed: ()=>
          Navigator.of(context).pop(),
          child: Text('Ok'),
          ),
        ],
    );
  }
}

_getFile(BuildContext context) async {

  File file1 = await FilePicker.getFile(type: FileType.CUSTOM,fileExtension:'pdf'); // will return a File object directly from the selected file
  Dio dio = new Dio();
  print(file1);
  FormData formData = new FormData();
  formData.add("file",
      UploadFileInfo(file1, file1.path));
  final response = await dio.post(
      'http://http://onenetwork.ddns.net/api/user_profile_update_resume.php?userid=201812017',
      data: formData);
  var re = jsonDecode(response.toString());
  var results= re["error"];

  if (file1 != null && results=="false") {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => UserProfile()));
   }

}
