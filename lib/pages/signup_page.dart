import 'package:first_wtf_app/model/user_detail.dart';
import 'package:first_wtf_app/provider/user_notifier.dart';
import 'package:first_wtf_app/widgets/custom_button.dart';
import 'package:first_wtf_app/widgets/custom_textfield.dart';
import 'package:first_wtf_app/widgets/password_textfield.dart';
import 'package:first_wtf_app/widgets/social_signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  Future<void> saveUser(UserDetail user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', user.name);
  await prefs.setString('email', user.email);
 
 
}
  @override
  Widget build(BuildContext context) {
    var userProv = Provider.of<UserNotifier>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            SizedBox(height: 100),
            Text(
              "Get Started",
              textAlign: TextAlign.center,
              style: GoogleFonts.play(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.blueAccent,
              ),
            ),
            Text(
              "Create an account to continue",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            CustomTextField(label: "Username",textEditingController: nameController,),
            CustomTextField(label: "Email", textEditingController: emailController,),
            PasswordTextfield(textEditingController: passwordController,),
            PasswordTextfield(textEditingController: confirmPasswordController, label: "Confirm Password",),
            CustomButton(
              text: 'Sign up',
              onPressed: () async {
                bool success = await userProv.signUp(
                  context: context,
                  userName: nameController.text,
                  password: passwordController.text,
                  email: emailController.text
                );
                if (success) {

       final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', nameController.text);
      await prefs.setString('email', emailController.text);

                }    
              }
            ),
            SocialSignIn(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("/login");
                  },
                  child: Text("Login", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
