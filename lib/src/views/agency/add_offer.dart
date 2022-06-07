import 'dart:convert';

import 'package:dzest_mobile/src/constants/app_colors.dart';
import 'package:dzest_mobile/src/models/add_offer_model.dart';
import 'package:dzest_mobile/src/services/add_offer_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class AddOffer extends StatefulWidget {
  const AddOffer({Key? key}) : super(key: key);

  @override
  State<AddOffer> createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController transController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController munucipalController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController streetaddressController = TextEditingController();

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  uploadFile() async {}

  late GetOffer offer;
  getData(title, description, price, state, municpal, zipcode, street_address) async {
    offer = await AddOfferService()
        .add_offer(title, description, int.parse(price), state, municpal, zipcode, street_address);
    for (var i = 0; i < imagefiles!.length; i++) {
      var postUri = Uri.parse("http://192.168.1.10:8000/api/add_image/");

      http.MultipartRequest request = http.MultipartRequest("POST", postUri);

      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('image', imagefiles![i].path);

      request.files.add(multipartFile);
      request.fields['offer'] = offer.id.toString();

      http.StreamedResponse response = await request.send();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Offer"),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
                  child: TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Offer Title',
                      floatingLabelStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.primaryColor,
                    style: const TextStyle(color: AppColors.textColor),

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'this field cant be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          openImages();
                        },
                        child: Text("Select Images"),
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // <-- Radius
                          ),
                          elevation: 0,
                        ),
                      ),
                      Divider(),
                      Text("Picked Images:"),
                      Divider(),
                      imagefiles != null
                          ? Wrap(
                              children: imagefiles!.map((imageone) {
                                return Container(
                                    child: Card(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.file(File(imageone.path)),
                                  ),
                                ));
                              }).toList(),
                            )
                          : Container()
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
                  child: TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Price',
                      floatingLabelStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.primaryColor,
                    style: const TextStyle(color: AppColors.textColor),

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'this field cant be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
                  child: TextFormField(
                    controller: typeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Offer Type',
                      floatingLabelStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.primaryColor,
                    style: const TextStyle(color: AppColors.textColor),

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'this field cant be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
                  child: TextFormField(
                    controller: transController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Transaction Type',
                      floatingLabelStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.primaryColor,
                    style: const TextStyle(color: AppColors.textColor),

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'this field cant be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
                  child: TextFormField(
                    controller: descriptionController,
                    minLines: 5,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Offer Description',
                      floatingLabelStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.primaryColor,
                    style: const TextStyle(color: AppColors.textColor),

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'this field cant be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: stateController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'State',
                            floatingLabelStyle: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                          cursorColor: AppColors.primaryColor,
                          style: const TextStyle(color: AppColors.textColor),

                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field cant be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: munucipalController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Municiapl',
                            floatingLabelStyle: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                          cursorColor: AppColors.primaryColor,
                          style: const TextStyle(color: AppColors.textColor),

                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field cant be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
                  child: TextFormField(
                    minLines: 2,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    controller: streetaddressController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Street Address',
                      floatingLabelStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.primaryColor,
                    style: const TextStyle(color: AppColors.textColor),

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'this field cant be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  height: 60,
                  width: 200,
                  padding: const EdgeInsets.fromLTRB(38, 0, 38, 0),
                  margin: const EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        getData(
                            titleController.text,
                            descriptionController.text,
                            priceController.text,
                            stateController.text,
                            munucipalController.text,
                            zipcodeController.text,
                            streetaddressController.text);
                      }
                    },
                    child: const Text(
                      'Add Offer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
