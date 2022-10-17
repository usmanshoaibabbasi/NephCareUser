import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neph_care_user/constants/colors.dart';
import 'package:neph_care_user/constants/routes.dart';
import 'package:neph_care_user/helpers/email_validation.dart';
import 'package:neph_care_user/helpers/file_picker.dart';
import 'package:neph_care_user/modals/userprofile_modal.dart';
import 'package:neph_care_user/services/get_profile_api.dart';
import 'package:neph_care_user/services/update_profile_api.dart';
import 'package:neph_care_user/widgets/textfield.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({Key? key}) : super(key: key);

  @override
  State<Editprofile> createState() => _EditprofileState();
}

String email = '';
String phone = '';
String name = '';
String error = '';
final _formKey = GlobalKey<FormState>();
UserProfileModal? userProfileModal;
var loading = true;
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController nameController = TextEditingController();

class _EditprofileState extends State<Editprofile> {
  XFile? _image;
  @override
  void initState() {
    setState(() {
      loading = true;
    });
    getprofileFunction().then((value) => {
          setState(() {
            loading = false; // Future is completed with a value.
            emailController.text = userProfileModal?.email;
            phoneController.text = userProfileModal?.phone;
            nameController.text = userProfileModal?.name;
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loading == true
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: WillPopScope(
                  onWillPop: () async {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      bottomnavigationroute,
                      (route) => false,
                    );
                    return true;
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 30),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                const Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 70,
                                  child: ClipOval(
                                    child: _image != null
                                        ? Image.file(
                                            File(_image!.path),
                                            fit: BoxFit.cover,
                                            height: 140,
                                            width: 140,
                                          )
                                        : userProfileModal?.image.toString() ==
                                                    '' ||
                                                userProfileModal?.image
                                                        .toString() ==
                                                    null
                                            ? Container(
                                                height: 140,
                                                width: 140,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      'assets/imguser.png',
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : CircleAvatar(
                                                radius: 70,
                                                child: ClipOval(
                                                  child: Image.network(
                                                      userProfileModal?.image,
                                                      height: 140,
                                                      width: 140,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(40)),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      XFile? file =
                                          await FilePickerHelper().getImage();
                                      setState(() {
                                        _image = file;
                                      });
                                    },
                                    child: IntrinsicWidth(
                                      child: Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.camera,
                                            color: basicthemecolor,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Change Image',
                                            style: TextStyle(
                                              color: basicthemecolor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                            color: basicthemecolor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                            border: Border.all(color: basicthemecolor),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 2),
                                color: HexColor('#404B63').withOpacity(0.1),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: inputField1(
                                    label1: 'Enter Name',
                                    context: context,
                                    prefixicon: Icon(
                                      CupertinoIcons.person,
                                      color: basicthemecolor,
                                      size: 22,
                                    ),
                                  ),
                                  validator: (val) =>
                                      val!.isEmpty ? 'Name is empty' : null,
                                  onChanged: (val) {
                                    setState(() {
                                      name = val;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: inputField1(
                                    label1: 'email',
                                    context: context,
                                    prefixicon: Icon(
                                      CupertinoIcons.envelope,
                                      color: basicthemecolor,
                                      size: 22,
                                    ),
                                  ),
                                  validator: (val) => val!.isValidEmail()
                                      ? null
                                      : 'email is not valid',
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.number,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: inputField1(
                                    label1: 'phone no',
                                    context: context,
                                    prefixicon: Icon(
                                      CupertinoIcons.phone,
                                      color: basicthemecolor,
                                      size: 22,
                                    ),
                                  ),
                                  validator: (val) => val!.length < 5
                                      ? 'Password more than 6 digit'
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      phone = val;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 46,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            print(name);
                                            print(email);
                                            print(phone);
                                            print(_image);
                                            // _image = userProfileModal?.image.toString() as XFile?;
                                            if (_image == null ||
                                                _image == '') {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please Select New Image",
                                                  backgroundColor:
                                                      basicthemecolor);
                                            } else {
                                              await updateProfileApi(
                                                  name,
                                                  email,
                                                  phone,
                                                  _image,
                                                  context);
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: basicthemecolor),
                                        child: const Text(
                                          'Update Account',
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                Text(
                                  error,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
