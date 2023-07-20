import 'package:flutter/material.dart';
import 'package:wecare/components/login_form.dart';
import 'package:wecare/components/social_button.dart';
import 'package:wecare/utils/text.dart';
import 'package:wecare/utils/config.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        //a widget that insets its child with
        //sufficient padding to avoid obstacles.
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppText.enText['welcome_text']!,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                AppText.enText['signIn_text']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              //login components here
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      LoginForm(),

                      // Add other content here if needed
                    ],
                  ),
                ),
              ),

              Center(
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      AppText.enText['forgot-password']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
              ),
              //add socaial button sign in
              const Spacer(),
              Center(
                child: Text(
                  //  why !
                  AppText.enText['social-login']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Config.spaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
                  //building social button
                  SocialButton(social: 'google'),
                  SocialButton(social: 'facebook'),
                ],
              ),

              // Add the button to navigate to the sign-up form page
            ],
          ),
        ),
      ),
    );
  }
}
