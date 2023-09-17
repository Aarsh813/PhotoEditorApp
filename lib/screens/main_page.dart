import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_editor_plus/image_editor_plus.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});
  @override
  MainPageState createState()=> MainPageState();
}
class MainPageState extends State<MainPage> {
  File ? selectedImage;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Photo Editor App"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              elevation: 20,
              color: Colors.grey,
              child: selectedImage!=null ? Image.file(selectedImage!) : const Text("Please select an Image"),
            ),
            ElevatedButton(
                onPressed: () {
                  pickImage();
                  },
                child: const Text("Choose Picture"))
          ],
        ),
      ),
    ));
  }
  Future pickImage() async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(returnImage==null) return;
    setState(() {
      selectedImage = File(returnImage.path);
    });
  }

}
