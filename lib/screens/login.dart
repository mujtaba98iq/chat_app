// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:chat_app/widgets/colors_and_icons.dart';
import 'package:chat_app/widgets/alert.dart';
import 'package:chat_app/widgets/showError.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'chat_screen.dart';

var url;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> fromstate = GlobalKey();

  var myemail, mypassword, myusername;
  var imagename;
  bool _isLogin = true;
  File? _selectedImage;

  void send(context) async {
    var formdata = fromstate.currentState;
    String errorMassage = "erorr";
    UserCredential authResult;

    if (formdata!.validate()) {
      formdata.save();

      showLoading(context);
      try {
        // var token=await FirebaseMessaging.instance.getToken();
        if (_isLogin) {
          showLoading(context);
          authResult = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: myemail, password: mypassword);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ChatScreen()));
        } else {
          if (_selectedImage == null) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar("Please Select An Image"));
          } else {
            authResult = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: myemail.trim(), password: mypassword);

            final ref = FirebaseStorage.instance
                .ref()
                .child("user_image")
                .child('${authResult.user!.uid}.jpg');

            await ref.putFile(_selectedImage!);

            url = await ref.getDownloadURL();
            await FirebaseFirestore.instance
                .collection("users")
                .doc(authResult.user!.uid)
                .set(
              {
                "username": myusername,
                "email": myemail.trim(),
                "password": mypassword,
                "userid": FirebaseAuth.instance.currentUser?.uid,
                "imageUrl": url

                // "token":token
              },
            );
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ChatScreen()));
          }
        }
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop();
        if (e.code == 'user-not-found') {
          errorMassage = "The user is not found!";
        } else if (e.code == 'wrong-password') {
          errorMassage = "The password is is not true!";
        } else if (e.code == 'weak-password') {
          errorMassage = "The Password is TOo Weak!";
        } else if (e.code == 'email-already-in-use') {
          errorMassage = "The email is already in use!";
        }
        ScaffoldMessenger.of(context).showSnackBar(snackBar(errorMassage));
      }
    } else {
      return;
    }
  }

  TextEditingController controllerEmail = TextEditingController();

  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Form(
      key: fromstate,
      child: Container(
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [g1, g2],
          ),
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(size.height * 0.030),
          child: OverflowBar(
            overflowSpacing:
                _isLogin ? size.height * 0.01 : size.height * 0.007,
            overflowAlignment: OverflowBarAlignment.center,
            children: [
              Image.asset(image1),
              _isLogin
                  ? Text(
                      "Wlcome Back!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Pacifico",
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: kWhiteColor.withOpacity(0.7)),
                    )
                  : CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : null,
                    ),
              _isLogin
                  ? const Text(
                      "Please, Log In.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                          color: kWhiteColor),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () async {
                            // _pickImage(ImageSource.camera);
                            _pickImage(ImageSource.camera);
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
                              SizedBox(
                                  width: 100,
                                  child: Text("Add Image From Camera"))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            // _pickImage(ImageSource.gallery);
                            _pickImage(ImageSource.gallery);
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
                              SizedBox(
                                  width: 100,
                                  child: Text("Add Image From Gallery"))
                            ],
                          ),
                        )
                      ],
                    ),
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              !_isLogin
                  ? TextFormField(
                      autocorrect: true,
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.words,
                      onSaved: (val) {
                        myusername = val;
                      },
                      validator: (text) {
                        if (text!.isEmpty || !RegExp(r'[a-z]').hasMatch(text)) {
                          return "Enter The right your Name";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: kInputColor),
                      controller: controllerUsername,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 25.0),
                        prefixIcon: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.person)),
                        filled: true,
                        hintText: "Name",
                        fillColor: kWhiteColor,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(37)),
                      ),
                    )
                  : Container(),
              TextFormField(
                autocorrect: false,
                enableSuggestions: false,
                textCapitalization: TextCapitalization.none,
                onSaved: (val) {
                  myemail = val;
                },
                validator: (text) {
                  if (text!.isEmpty ||
                      !RegExp(r'[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                          .hasMatch(text)) {
                    return "Enter The right your Email";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                style: const TextStyle(color: kInputColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        userIcon,
                      )),
                  filled: true,
                  hintText: "Email",
                  fillColor: kWhiteColor,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(37)),
                ),
              ),
              TextFormField(
                onSaved: (val) {
                  mypassword = val;
                },
                validator: (text) {
                  if (text!.isEmpty || RegExp(r'^[0-9]+$').hasMatch(text)) {
                    return "The Email must be grager than 2 letter";
                  }
                  return null;
                },
                obscureText: true,
                style: const TextStyle(color: kInputColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        keyIcon,
                      )),
                  filled: true,
                  hintText: "Password",
                  fillColor: kWhiteColor,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(37)),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: size.height * 0.080,
                  decoration: BoxDecoration(
                      color: kButtonColor,
                      borderRadius: BorderRadius.circular(37)),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                        color: kWhiteColor, fontWeight: FontWeight.w700),
                  ),
                ),
                onPressed: () {
                  send(context);
                },
              ),
              _isLogin
                  ? SizedBox(
                      height: size.height * 0.010,
                    )
                  : Container(),
              SvgPicture.asset("assets/icons/deisgn.svg"),
              _isLogin
                  ? SizedBox(
                      height: size.height * 0.010,
                    )
                  : Container(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: size.height * 0.080,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 45,
                            spreadRadius: 0,
                            color: Color.fromRGBO(120, 37, 139, 0.25),
                            offset: Offset(0, 25),
                          )
                        ],
                        color: const Color.fromRGBO(
                          255,
                          255,
                          255,
                          0.28,
                        ),
                        borderRadius: BorderRadius.circular(37)),
                    child: Text(
                      _isLogin ? "Create an Account" : "I Have An acount",
                      style: const TextStyle(
                          color: kWhiteColor, fontWeight: FontWeight.w700),
                    )),
                onPressed: () async {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
              ),
            ],
          ),
        )),
      ),
    ));
  }

  Future _pickImage(ImageSource src) async {
    final retrunimage = await ImagePicker()
        .pickImage(source: src, imageQuality: 50, maxWidth: 150);

    if (retrunimage == null) return;
    setState(() {
      imagename = retrunimage.name;
      _selectedImage = File(retrunimage.path);
    });
  }
}
