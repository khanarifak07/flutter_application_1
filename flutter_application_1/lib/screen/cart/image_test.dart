// import 'dart:io';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class Cart extends StatefulWidget {
//   const Cart({super.key});

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   File? image;
//   List<XFile>? images;
//   final ImagePicker _imagePicker = ImagePicker();
//   //
//   Future<void> pickImage() async {
//     var pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         image = File(pickedImage.path);
//       });
//     }
//   }

//   //
//   Future<void> picMultipleImages() async {
//     var pickedMultipleImages = await _imagePicker.pickMultiImage();
//     if (pickedMultipleImages.isNotEmpty) {
//       setState(() {
//         images = pickedMultipleImages;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           children: [
//             Center(
//               child: GestureDetector(
//                 onTap: pickImage,
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: image != null ? FileImage(image!) : null,
//                   child: image == null ? const Icon(Icons.add) : null,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text("Add Single Image"),
//             const SizedBox(height: 20),
//             images != null && images!.isNotEmpty
//                 ? CarouselSlider.builder(
//                     itemCount: images!.length,
//                     itemBuilder:
//                         (BuildContext context, int index, int realIndex) {
//                       return GestureDetector(
//                         onTap: picMultipleImages,
//                         child: Container(
//                           height: 200,
//                           width: double.maxFinite,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Stack(
//                               children: [
//                                 Image.file(
//                                   File(images![index].path),
//                                   fit: BoxFit.cover,
//                                   width: double.infinity,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.bottomRight,
//                                   child: IconButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           images!.removeAt(index);
//                                         });
//                                       },
//                                       icon: const Icon(
//                                         Icons.delete,
//                                         color: Colors.red,
//                                         size: 30,
//                                       )),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     options: CarouselOptions(
//                       viewportFraction: 1,
//                       enableInfiniteScroll: false,
//                       autoPlay: true,
//                       autoPlayCurve: Curves.decelerate,
//                     ),
//                   )
//                 : GestureDetector(
//                     onTap: picMultipleImages,
//                     child: Container(
//                       height: 200,
//                       width: double.maxFinite,
//                       decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: const Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.photo, size: 50, color: Colors.grey),
//                           SizedBox(height: 10),
//                           Text(
//                             "Add Multiple Images",
//                             style: TextStyle(fontSize: 20, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//             const SizedBox(height: 40),
//             MaterialButton(
//               splashColor: Colors.red.withAlpha(100),
//               materialTapTargetSize: MaterialTapTargetSize.padded,
//               onPressed: () {},
//               minWidth: 200,
//               height: 50,
//               color: Colors.green,
//               child: const Text("Button"),
//             ),
//             const SizedBox(height: 40),
//             TextButton(
//               onPressed: () {},
//               style: ButtonStyle(
//                 backgroundColor: WidgetStateProperty.all(
//                   Colors.red,
//                 ),
//                 shape: WidgetStateProperty.all(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                       10,
//                     ),
//                   ),
//                 ),
//                 padding: WidgetStateProperty.all(
//                   const EdgeInsets.all(12),
//                 ),
//               ),
//               child: const Text("Submit"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
