
import 'package:first_wtf_app/provider/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialSignIn extends StatelessWidget {
  const SocialSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var userP = Provider.of<UserNotifier>(context);
    return Column(
      children: [
        Row(
          spacing: 8,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: Divider()),
            Text("Sign in with"),
            Expanded(child: Divider()),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            InkWell(
              onTap: () {
                userP.signInWithGoogle(context);
              },
              child: Image.asset(
                "assets/snapchat.png",
                width: 50,
                height: 50,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Image.asset(
                "assets/telegram.png",
                width: 50,
                height: 50,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Image.asset("assets/whatsapp.png", width: 50, height: 50),
            ),
          ],
        ),
      ],
    );
  }
}
