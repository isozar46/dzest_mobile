import 'package:dzest_mobile/src/constants/app_colors.dart';
import 'package:dzest_mobile/src/models/add_offer_model.dart';
import 'package:dzest_mobile/src/services/add_offer_service.dart';
import 'package:dzest_mobile/src/services/base_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class EditOffer extends StatefulWidget {
  const EditOffer({
    Key? key,
    required this.offerID,
  }) : super(key: key);
  final int offerID;
  @override
  State<EditOffer> createState() => _AddOfferState();
}

class _AddOfferState extends State<EditOffer> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController =
      TextEditingController(text: "Your initial value");
  TextEditingController descriptionController =
      TextEditingController(text: "Your initial value");
  TextEditingController priceController =
      TextEditingController(text: "Your initial value");
  TextEditingController stateController =
      TextEditingController(text: "Your initial value");
  TextEditingController munucipalController =
      TextEditingController(text: "Your initial value");
  TextEditingController streetaddressController =
      TextEditingController(text: "Your initial value");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Offer"),
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
                        /*
                        getData(
                            titleController.text,
                            descriptionController.text,
                            priceController.text,
                            stateController.text,
                            munucipalController.text,
                            streetaddressController.text);*/
                      }
                    },
                    child: const Text(
                      'Update Offer',
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
