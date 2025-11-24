import 'package:first_wtf_app/widgets/custom_button.dart';
import 'package:first_wtf_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:      Padding(
             padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 40.0),
             child: CustomButton(
                text: "Upadate",
                onPressed: () {
                  
                  
                },
              ),
           ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back),
                  Text(
                    "Profile",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Icon(Icons.share),
                ],
              ),
            ),
          ),
          SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              spacing: 24.0,
              children: [
                CustomTextField(
                  label: "Username",
                  textEditingController: nameController,
                ),
                                CustomTextField(
                  label: "Email",
                  textEditingController: nameController,
                ),
                CustomTextField(
                  label: "password",
                  textEditingController: nameController,
                ),
              

              ],
            ),
          ),
      
        ],
      ),
    );
  }
}
