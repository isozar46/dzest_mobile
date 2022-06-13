import 'package:dzest_mobile/src/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AgencyProfile extends StatefulWidget {
  const AgencyProfile({Key? key}) : super(key: key);

  @override
  State<AgencyProfile> createState() => _AgencyProfileState();
}

class _AgencyProfileState extends State<AgencyProfile> {
  TextEditingController nameController =
      TextEditingController(text: "el ghazal");
  TextEditingController emailController =
      TextEditingController(text: "agency@gmail.com");
  TextEditingController phoneController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
            child: Image.asset('assets/images/circular image.png'),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(38, 10, 38, 0),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'name',
                floatingLabelStyle: TextStyle(
                  color: AppColors.primaryColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2.0,
                  ),
                ),
              ),
              cursorColor: AppColors.primaryColor,
              style: const TextStyle(color: AppColors.textColor),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(38, 10, 38, 0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'email',
                floatingLabelStyle: TextStyle(
                  color: AppColors.primaryColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2.0,
                  ),
                ),
              ),
              cursorColor: AppColors.primaryColor,
              style: const TextStyle(color: AppColors.textColor),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(38, 10, 38, 0),
            child: TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'phone',
                floatingLabelStyle: TextStyle(
                  color: AppColors.primaryColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2.0,
                  ),
                ),
              ),
              cursorColor: AppColors.primaryColor,
              style: const TextStyle(color: AppColors.textColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 60,
              width: 200,
              padding: const EdgeInsets.fromLTRB(38, 0, 38, 0),
              child: ElevatedButton(
                child: const Text(
                  'Update profile',
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
                onPressed: () {},
              )),
        ],
      )),
    );
  }
}
