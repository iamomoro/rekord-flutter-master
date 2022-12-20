import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseImage.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onSelect;
  final imageUrl;
  ImageInput({this.onSelect, this.imageUrl});
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _imageFile;
  Future<void> _getImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().getImage(source: source, maxWidth: 200.0);

    setState(() {
      _imageFile = File(image.path);
    });
    widget.onSelect(image);
    Navigator.pop(context);
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Pick an Image",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.all(10.0),
                      onPressed: () => _getImage(context, ImageSource.camera),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.camera_alt,
                            size: 40.0,
                            color: Colors.pinkAccent,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Camera",
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20.0),
                    FlatButton(
                      padding: EdgeInsets.all(10.0),
                      onPressed: () => _getImage(context, ImageSource.gallery),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.photo_library,
                            size: 40.0,
                            color: Colors.blueGrey,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () => _openImagePicker(context),
          child: _imageFile == null
              ? Center(
                  child: Container(
                    height: 80,
                    width: 80,
                    child: CircleAvatar(
                        child: ClipOval(
                            child: BaseImage(
                      radius: 40,
                      height: 150,
                      imageUrl: widget.imageUrl,
                    ))),
                  ),
                )
              : Center(
                  child: CircleAvatar(
                      radius: 40.0,
                      child: ClipOval(
                        child: Image.file(
                          _imageFile,
                          fit: BoxFit.cover,
                          height: 150.0,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topCenter,
                        ),
                      )),
                ),
        )
      ],
    );
  }
}
