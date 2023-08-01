import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserPickedImage extends StatefulWidget {
  const UserPickedImage({super.key});

  @override
  State<UserPickedImage> createState() => _UserPickedImageState();
}

class _UserPickedImageState extends State<UserPickedImage> {
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEst2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
               CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    backgroundImage:_selectedImage != null? FileImage(_selectedImage!):null,
                  ),
               
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                // _pickImage(ImageSource.camera);
                _pciekGalory();
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.camera,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(width: 100, child: Text("Add Image From Camera"))
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // _pickImage(ImageSource.gallery);
                  _pciekGalory();
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.image,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(width: 100, child: Text("Add Image From Gallery"))
                ],
              ),
            )
          ],
        ),
          ],
        ),
      ),
    );
  }

  Future _pciekGalory() async {
    final retrunimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (retrunimage == null) return;
    setState(() {
      _selectedImage = File(retrunimage.path);
    });
  }
}



















// import 'dart:io';
// import 'dart:math';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart';

// class UserImagePicker extends StatefulWidget {
//   const UserImagePicker({super.key});

//   @override
//   State<UserImagePicker> createState() => _UserImagePickerState();
// }

// class _UserImagePickerState extends State<UserImagePicker> {
//   @override
//   Widget build(BuildContext context) {
//     // File? _pickedImage;
//     // bool ontapAddNote = false;
//     // final ImagePicker _picker = ImagePicker();

  
//     // Future _pickImage(ImageSource src) async {
//     //   final pickedImageFile =
//     //       await _picker.pickImage(source: ImageSource.camera);

//     //   // if (pickedImageFile != null) {
//     //     setState(() {
//     //       _pickedImage = File(pickedImageFile!.path);
//     //     });
//     //     // widget.imagePickFn(_pickedImage!);
//     //   // } else {
//     //   //   ScaffoldMessenger.of(context)
//     //   //       .showSnackBar(snackBar("please Pick an Image"));
//     //   // }
//     // }
//      File? pickedImage;
//     bool ontapAddNote = false;
//     final ImagePicker picker = ImagePicker();


//     var imagepecker = ImagePicker();
//     // bool ontapAddNote = false;
//     File? file;
 
//     Future uploadImgaes(source) async {
//       var random = Random().nextInt(10000000);

//       final imgpicker = await imagepecker.pickImage(source: source);
//       if (imgpicker != null) {
//         var nameimage = imgpicker.name;
//         file = File(imgpicker.path);
//         print("========================================");
//         print("$random$nameimage");

//         //start upload image

//         if (ontapAddNote == true) {
//           // print(
//           //     "====================================================================");
//           // print("URL : $imageurl");
//         }

//         //end upload image

//       } else {
//       ScaffoldMessenger.of(context)
//             .showSnackBar(snackBar("please Pick an Image"));
//       }
//       final imtTemp = File(imgpicker!.path);
//       setState(() {
//         file = imtTemp;
//       });
//     }

//     return Column(
//       children: [
//         CircleAvatar(
//             radius: 40,
//             backgroundColor: Colors.grey,
//             backgroundImage:
//                 file != null ? FileImage(file!) : null),
//         pickedImage != null
//             ? Image.file(
//                 file!,
//                 width: 200,
//                 height: 200,
//                 fit: BoxFit.cover,
//               )
//             : Image.asset("assets/images/image_1.png"),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             InkWell(
//               onTap: () {
//                 // _pickImage(ImageSource.camera);
//                 uploadImgaes(ImageSource.camera);
//               },
//               child: Row(
//                 children: const [
//                   Icon(
//                     Icons.camera,
//                     color: Colors.white,
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   SizedBox(width: 100, child: Text("Add Image From Camera"))
//                 ],
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 // _pickImage(ImageSource.gallery);
//                   uploadImgaes(ImageSource.gallery);
//               },
//               child: Row(
//                 children: const [
//                   Icon(
//                     Icons.image,
//                     color: Colors.white,
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   SizedBox(width: 100, child: Text("Add Image From Gallery"))
//                 ],
//               ),
//             )
//           ],
//         ),

//         const SizedBox(height: 20,),
//         pickedImage!=null?Image.file(pickedImage):const Text("PLLEEEEEEEES SELect image")
//       ],
//     );
//   }

//   SnackBar snackBar(errorMassage) {
//     return SnackBar(
//       content: Stack(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             height: 90,
//             decoration: const BoxDecoration(
//                 color: Color(0xFFC72C41),
//                 borderRadius: BorderRadius.all(Radius.circular(20))),
//             child: Row(
//               children: [
//                 const SizedBox(
//                   width: 48,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "oh Snap!",
//                         style: TextStyle(color: Colors.white, fontSize: 25),
//                       ),
//                       Text(
//                         errorMassage,
//                         style:
//                             const TextStyle(fontSize: 20, color: Colors.white),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//     );
//   }
// }
