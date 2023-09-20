import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'dart:core';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  File? selectedImage;
  // ignore: prefer_typing_uninitialized_variables
  var editedImage;
  // ignore: prefer_typing_uninitialized_variables
  Image ? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Photo Editor App"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                            onPressed: () {
                              pickImage(ImageSource.gallery);
                            },
                            style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                            shadowColor: Colors.black,
                              textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)
                        ),
                            child: const Text("Choose Picture from\nGallery",
                                textAlign: TextAlign.center),),
                      ElevatedButton(
                          onPressed: () {
                            pickImage(ImageSource.camera);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              shadowColor: Colors.black,
                              textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)
                          ),
                          child: const Text(
                            "Choose Picture from\nCamera",
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 550,
                    child: selectedImage != null
                        ? image
                        : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text("Please select an Image",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    child: selectedImage != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    revertBack();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      shadowColor: Colors.black,
                                      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)
                                  ),
                                  child: const Text(
                                    "Revert Back",
                                    textAlign: TextAlign.center,
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    edit();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      shadowColor: Colors.black,
                                      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)
                                  ),
                                  child: const Text(
                                    "Apply Filter",
                                    textAlign: TextAlign.center,
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    saveImage(editedImage) ;
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurpleAccent,
                                      shadowColor: Colors.black,
                                      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)
                                  ),
                                  child: const Text(
                                    "Save Picture",
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          )
                        : const Text(""),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  //Picking Image
  Future pickImage(src) async {
    final returnImage = await ImagePicker().pickImage(source: src);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      image = Image.file(selectedImage!, fit: BoxFit.contain);
    });
  }

  //Extra function to open ImageEditor
  Future editImage() async {
    var edited = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageEditor(
          image: selectedImage, // <-- Uint8List of image
          appBarColor: Colors.blue,
        ),
      ),
    );
    setState(() {
      image = Image.memory(edited, fit: BoxFit.contain);
      editedImage = edited;
    });
  }

  //Reverting back to original image
  Future revertBack() async {
    setState(() {
      image = Image.file(selectedImage!, fit: BoxFit.contain);
      editedImage = null;
    });
  }

  //Saving Image
  Future saveImage(editedImage) async {
    if(editedImage==null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Nothing to Save"),
      ));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Your image is saved to the gallery"),
      ));
      await ImageGallerySaver.saveImage(editedImage);
    }
  }

  //Applying Filter
  Future edit() async {
    final inputImage = img.decodeImage(selectedImage!.readAsBytesSync());
    final editImage = img.bleachBypass(inputImage!);
    setState(() {
      editedImage = Uint8List.fromList(img.encodePng(editImage));
      image = Image.memory(editedImage,fit: BoxFit.contain);

    });
  }
}
