// import 'package:chat_app/colors_and_icons.dart';
// import 'package:chat_app/screens/login.dart';
// import 'package:chat_app/widgets/alert.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'homepage.dart';

// // ignore: must_be_immutable
// class SiginUp extends StatelessWidget {
//   SiginUp({super.key});
//   GlobalKey<FormState> fromstate = GlobalKey();
//   bool isVerfied = false;

//   void send(context) async {
//     var formdata = fromstate.currentState;
//     if (formdata!.validate()) {
//       try {
//         // var token=await FirebaseMessaging.instance.getToken();
//         showLoading(context);
//         await FirebaseFirestore.instance.collection("users").add({
//           "username": controllerUsername.text,
//           "email": controllerEmail.text,
//           "userid": FirebaseAuth.instance.currentUser?.uid,
//           // "token":token
//         });
//         Navigator.of(context)
//             .pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'weak-password') {
//           Navigator.of(context).pop();

//           ScaffoldMessenger.of(context)
//               .showSnackBar(snackBar("The Password is TOo Weak!"));
//         } else if (e.code == 'email-already-in-use') {
//           Navigator.of(context).pop();
//           ScaffoldMessenger.of(context)
//               .showSnackBar(snackBar("The email is already in use"));
//         }
//       }
//     } else {
//       return;
//     }
//   }

//   TextEditingController controllerEmail = TextEditingController();
//   TextEditingController controllerPassword = TextEditingController();
//   TextEditingController controllerUsername = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         body: Form(
//       autovalidateMode: AutovalidateMode.always,
//       key: fromstate,
//       child: Container(
//         height: double.maxFinite,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [g1, g2],
//           ),
//         ),
//         child: SingleChildScrollView(
//             child: Padding(
//           padding: EdgeInsets.all(size.height * 0.030),
//           child: OverflowBar(
//             overflowSpacing: size.height * 0.01,
//             overflowAlignment: OverflowBarAlignment.center,
//             children: [
//               Image.asset(image1),
//               const Text(
//                 "Please, Sigin Up.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                     color: kWhiteColor),
//               ),
//               // SizedBox(
//               //   height: size.height * 0.01,
//               // ),
//               TextFormField(
//                 validator: (text) {
//                   if (text!.isEmpty || !RegExp(r'[a-z]').hasMatch(text)) {
//                     return "Enter The right your Name";
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.text,
//                 style: const TextStyle(color: kInputColor),
//                 controller: controllerUsername,
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
//                   prefixIcon: IconButton(
//                       onPressed: () {}, icon: const Icon(Icons.person)),
//                   filled: true,
//                   hintText: "Name",
//                   fillColor: kWhiteColor,
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(37)),
//                 ),
//               ),
//               TextFormField(
//                 validator: (text) {
//                   if (text!.isEmpty ||
//                       !RegExp(r'[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
//                           .hasMatch(text)) {
//                     return "Enter The right your Email";
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.text,
//                 controller: controllerEmail,
//                 style: const TextStyle(color: kInputColor),
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
//                   prefixIcon: IconButton(
//                       onPressed: () {}, icon: const Icon(Icons.email)),
//                   filled: true,
//                   hintText: "Email",
//                   fillColor: kWhiteColor,
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(37)),
//                 ),
//               ),
//               TextFormField(
//                 validator: (text) {
//                   if (text!.isEmpty || RegExp(r'^[0-9]+$').hasMatch(text)) {
//                     return "Enter Correct password!";
//                   }
//                   return null;
//                 },
//                 obscureText: true,
//                 style: const TextStyle(color: kInputColor),
//                 controller: controllerPassword,
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
//                   prefixIcon: IconButton(
//                       onPressed: () {},
//                       icon: SvgPicture.asset(
//                         keyIcon,
//                       )),
//                   filled: true,
//                   hintText: "Password",
//                   fillColor: kWhiteColor,
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(37)),
//                 ),
//               ),
//               CupertinoButton(
//                 padding: EdgeInsets.zero,
//                 child: Container(
//                   alignment: Alignment.center,
//                   width: double.infinity,
//                   height: size.height * 0.080,
//                   decoration: BoxDecoration(
//                       color: kButtonColor,
//                       borderRadius: BorderRadius.circular(37)),
//                   child: const Text(
//                     "Continue",
//                     style: TextStyle(
//                         color: kWhiteColor, fontWeight: FontWeight.w700),
//                   ),
//                 ),
//                 onPressed: () {
//                   send(context);
//                 },
//               ),
//               // SizedBox(
//               //   height: size.height * 0.010,
//               // ),
//               SvgPicture.asset("assets/icons/deisgn.svg"),
//               // SizedBox(
//               //   height: size.height * 0.010,
//               // ),
//               CupertinoButton(
//                 padding: EdgeInsets.zero,
//                 child: Container(
//                   alignment: Alignment.center,
//                   width: double.infinity,
//                   height: size.height * 0.080,
//                   decoration: BoxDecoration(
//                       boxShadow: const [
//                         BoxShadow(
//                           blurRadius: 45,
//                           spreadRadius: 0,
//                           color: Color.fromRGBO(120, 37, 139, 0.25),
//                           offset: Offset(0, 25),
//                         )
//                       ],
//                       color: const Color.fromRGBO(
//                         255,
//                         255,
//                         255,
//                         0.28,
//                       ),
//                       borderRadius: BorderRadius.circular(37)),
//                   child: const Text(
//                     "I Have Account",
//                     style: TextStyle(
//                         color: kWhiteColor, fontWeight: FontWeight.w700),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(
//                       builder: (context) => const Login(),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         )),
//       ),
//     ));
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
