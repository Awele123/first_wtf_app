import 'package:first_wtf_app/model/user_detail.dart';
import 'package:first_wtf_app/pages/profile_page.dart';
import 'package:first_wtf_app/widgets/custom_button.dart';
import 'package:first_wtf_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? savedName;
  String? savedEmail;
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    nameController.text = prefs.getString('name') ?? '';
    emailController.text = prefs.getString('email') ?? '';

    setState(() {});
  }

  Future<void> updateUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('email', emailController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 40.0),
        child: CustomButton(
          text: "Upadate",
          onPressed: 
           updateUser,
        
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfilePage();
                          },
                        ),
                      );
                    },
                    child: Icon(Icons.arrow_back),
                  ),
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
                  hintText: savedName,
                  label: "Username",
                  textEditingController: nameController,
                ),
                CustomTextField(
                  label: "Email",
                  textEditingController: emailController,
                ),
                CustomTextField(
                  label: "password",
                  textEditingController: passwordController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
