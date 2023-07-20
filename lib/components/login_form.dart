import 'package:flutter/material.dart';
import 'package:wecare/utils/config.dart';
import 'package:wecare/components/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wecare/components/sign_upform.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _errorMessage;
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscurePassword,
            cursorColor: Config.primaryColor,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: _obscurePassword
                    ? const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                        color: Config.primaryColor,
                      ),
              ),
            ),
          ),
          if (_errorMessage != null)
            Text(
              _errorMessage!,
              style: TextStyle(color: Colors.red),
            ),
          if (!_isLoading)
            Button(
              width: double.infinity,
              title: 'Sign In',
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'main');
              },
              // onPressed: ()
              // async {
              //   setState(() {
              //     _isLoading = true;
              //   });

              //   try {
              //     final UserCredential userCredential =
              //         await _auth.signInWithEmailAndPassword(
              //       email: _emailController.text.trim(),
              //       password: _passwordController.text,
              //     );

              //     if (userCredential.user != null) {
              //       Navigator.of(context).pushNamed('main');
              //     }
              //   } on FirebaseAuthException catch (e) {
              //     setState(() {
              //       _errorMessage = "Incorrect Email or Password";
              //     });
              //   }

              //   setState(() {
              //     _isLoading = false;
              //   });
              // },
              disable: false,
            ),
          if (_isLoading) CircularProgressIndicator(),
          TextButton(
            style: ElevatedButton.styleFrom(
                // backgroundColor: Config.primaryColor,
                ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpForm(),
                ),
              );
            },
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Config.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
