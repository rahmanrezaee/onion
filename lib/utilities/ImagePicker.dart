// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';

// class ImagePicker extends StatefulWidget {
//   Function getImage;

//   @override
//   _ImagePickerState createState() => _ImagePickerState();

//   static pickImage({ImageSource source, int imageQuality}) {}
//   }
  
//   class _ImagePickerState extends State<ImagePicker> {
//     @override
//     Widget build(BuildContext context) {
//       final flatButtonColor = Theme.of(context).primaryColor;
//       return showModalBottomSheet(
//           context: context,
//           builder: (BuildContext context) {
//             return Container(
//               height: 150.0,
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     height: 50,
//                     alignment: Alignment.center,
//                     margin: EdgeInsets.all(0),
//                     padding: EdgeInsets.all(0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(0)),
//                     ),
//                     width: double.infinity,
//                     child: Text(
//                       'Choice Image',
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       FlatButton(
//                         textColor: flatButtonColor,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             FaIcon(FontAwesomeIcons.camera),
//                             Text('Comara'),
//                           ],
//                         ),
//                         onPressed: () {
//                           _getImage(context, ImageSource.camera);
//                         },
//                       ),
//                       FlatButton(
//                         textColor: flatButtonColor,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             FaIcon(FontAwesomeIcons.images),
//                             Text('Gallary'),
//                           ],
//                         ),
//                         onPressed: () {
//                           _getImage(context, ImageSource.gallery);
//                         },
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             );
//           });
//     }
  
    
//     void _getImage(BuildContext context, ImageSource source) async {
//       File image = await ImagePicker.pickImage(
//       source: source,
//       imageQuality: 85,
//     );

   

//     Navigator.pop(context);

//     if (_imageFile != null) {
//       await _cropImage();
//     }

//     setState(() {
//       _isUploadingImage = true;
//     });

//     try {
//       Map result = await Auth().uploadFile(_imageFile, "profile");
//       user.profile = result['name'];
//     } on UploadException catch (e) {
//       _scaffoldKey.currentState
//           .showSnackBar(showSnackbar(e.cause, Icon(Icons.error), Colors.red));
//     }

   
//   }
  
// }
