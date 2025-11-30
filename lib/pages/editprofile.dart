import 'package:first_wtf_app/bottom_navigation.dart';
import 'package:first_wtf_app/model/user_detail.dart';
import 'package:first_wtf_app/pages/home_page.dart';
import 'package:first_wtf_app/pages/profile_page.dart';
import 'package:first_wtf_app/provider/user_notifier.dart';
import 'package:first_wtf_app/widgets/custom_button.dart';
import 'package:first_wtf_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();

    final user = Provider.of<UserNotifier>(context, listen: false).loggedInUser;

    if (user != null) {
      nameController.text = user.name;
      emailController.text = user.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 40.0),
        child: CustomButton(
          text: "Update",
          textStyle: TextStyle(fontSize: 60.0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BottomNavigation();
                },
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.blue,),
                child: Padding(
                  padding: const EdgeInsets.only(top: 35.0, bottom: 40.0),
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
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.share, color: Colors.white),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -60,
                left: 0,
                right: 0,
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,

                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/person.png"),
                      ),
                      CircleAvatar(
                        radius: 16,
                        child: Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 80.0),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20.0,
            ),
            child: Column(
              spacing: 24.0,
              children: [
                CustomTextField(
                  label: "",
                  textEditingController: nameController,
                ),
                CustomTextField(
                  label: "",
                  readOnly: true,

                  textEditingController: emailController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
