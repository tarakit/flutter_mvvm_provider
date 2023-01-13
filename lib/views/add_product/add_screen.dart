import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/view_models/home_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var imageFile;
  var homeViewModel = HomeViewModel();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            _getImageFromGalleryOrCamera('camera');
          }, icon: const Icon(Icons.camera)),
          IconButton(onPressed: (){
            _getImageFromGalleryOrCamera('gallery');
          }, icon: const Icon(Icons.browse_gallery)),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext ctx) => homeViewModel,
        child: Consumer(
          builder: (ctx, image, _) {
            print('image url ${homeViewModel.imageResponse.data!.url}');
            return Center(
              child: imageFile == null ? Text('No Image') :
              Image.file(imageFile, fit: BoxFit.cover,),
            );
          }
        ),
      ),
    );
  }

  _getImageFromGalleryOrCamera(String type) async {
        print('type $type');
       PickedFile? pickedFile = await ImagePicker().getImage(
           source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
           maxWidth: 1800,
           maxHeight: 1800
       );
        if(pickedFile != null){
          imageFile = File(pickedFile.path);
          setState(() {
          });
          homeViewModel.uploadImage(pickedFile.path);
        }else
          print('image not picked');

  }


}
