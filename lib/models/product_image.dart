import 'dart:io';

import 'package:demo_fllutter_cmdev/constants/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProductImage extends StatefulWidget {
  final Function(File imageFile) callback;
  final String imageURL;
  const ProductImage(this.callback, this.imageURL);

  @override
  _ProductImageState createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  File _imageFile; // for seve imagefile
  final _imagePicker = ImagePicker(); // for open dialog
  String _imageURL;

  @override
  void initState() {
    _imageURL = widget.imageURL;
    super.initState();
  }

  @override
  void dispose() {
    _imageFile?.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPickerImage(),
          _buildPreviewImage(),
        ],
      ),
    );
  }

  // # This method is for picking image from device.
  OutlinedButton _buildPickerImage() {
    return OutlinedButton.icon(
      onPressed: () {
        _modalPickerImage();
      },
      icon: FaIcon(
        FontAwesomeIcons.image,
        color: Colors.black87,
      ),
      label: Text(
        'Choose image',
        style: TextStyle(color: Colors.black87),
      ),
    );
  }

  // # This method is for preview image.
  Widget _buildPreviewImage() {
    // fun var.
    final container = (Widget imageFile) => Container(
          color: Colors.grey[100],
          margin: EdgeInsets.only(top: 4),
          alignment: Alignment.center,
          height: 350,
          child: imageFile,
        );

    // checking imagefile
    if ((_imageURL == null || _imageURL.isEmpty) && _imageFile == null) {
      return SizedBox();
    } else {
      return _imageURL != null
          ? container(Image.network('${API.IMAGE_URL}/$_imageURL'))
          : Stack(
              children: [
                container(Image.file(_imageFile)),
                _buildDeleteImageButton(),
              ],
            );
    }
  }

  // # This method is for deleting image.
  Positioned _buildDeleteImageButton() => Positioned(
        right: 0,
        child: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black54,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            setState(() {
              print('$_imageFile is deleted');
              _imageFile = null; //delete imagefile
              widget.callback(null);
            });
          },
        ),
      );

  // # This method is for setting and showing bottomsheet.
  void _modalPickerImage() {
    // # Functionnal var. recieve param icon, title, imagesource
    final buildListTile =
        (IconData icon, String title, ImageSource imageSource) => ListTile(
              leading: Icon(icon),
              title: Text(title),
              onTap: () async {
                print('_modalPickerImage');

                // pop bottomsheet out
                Navigator.pop(context);
                _pickImage(imageSource);
              },
            );

    // show bottom sheet
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // open camera
          // clickable by ontap()
          buildListTile(
            Icons.photo_camera, // icon
            'Take picture from camera', // title
            ImageSource.camera, // imagesource
          ),
          // open gallery
          buildListTile(
            Icons.photo_library,
            'Choose photo from library',
            ImageSource.gallery,
          ),
        ],
      ),
    );
  }

  // # This method is for displaying picked image.
  void _pickImage(ImageSource imageSource) {
    _imagePicker
        .getImage(
          source: imageSource,
          imageQuality: 70,
          maxHeight: 500,
          maxWidth: 500,
        )
        .then(
          (file) => {
            if (file != null)
              {
                // display imagefile
                // setState(() {
                //   _imageFile = File(file.path);
                //   print("imagepath : $_imageFile");
                // }),
                _cropImage(file.path),
              }
          },
        );
  }

  // # This method is for cropping picked image.
  // # Then display image.
  _cropImage(String imageFile) {
    ImageCropper.cropImage(
      sourcePath: imageFile,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      // android setting
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      // ios setting
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    ).then((file) => {
          if (file != null)
            {
              setState(() {
                _imageFile = file;
                print('Imagefile : $_imageFile');

                // use callback
                widget.callback(_imageFile);
                _imageURL = null;
              })
            }
        });
  }
}
