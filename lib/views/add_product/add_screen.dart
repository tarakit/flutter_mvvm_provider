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
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ChangeNotifierProvider<HomeViewModel>(
                create: (BuildContext ctx) => homeViewModel,
                child: Consumer(
                    builder: (ctx, image, _) {
                      // print('image url ${homeViewModel.imageResponse.data!.url}');
                      return Center(
                        child: imageFile == null ? Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/681px-Placeholder_view_vector.svg.png',
                        width: 150, height: 150) :
                        Image.file(imageFile, fit: BoxFit.cover,width: 150, height: 150),
                      );
                    }
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title'
                )
              ),
              SizedBox(height: 10,),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Rating'
                  )
              ),
              SizedBox(height: 10,),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description'
                  ),
              ),
              SizedBox(height: 10,),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Quantity'
                  )
              ),
              SizedBox(height: 10,),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Price'
                  )
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){}, child: Text('Post'))
            ],
          ),
        ),
      )
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
