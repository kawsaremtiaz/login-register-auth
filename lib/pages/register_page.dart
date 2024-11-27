import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/components/my_button.dart';
import 'package:flutter_authentication/components/my_textfield.dart';
import 'package:flutter_authentication/components/square_tile.dart';
import 'package:flutter_authentication/services/auth_service.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  void Function()? onTap;
  RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confermPasswordController = TextEditingController();

  // sign user in methord
  void signUserUp() async {
    // show loading circle

    try {
      if (passwordController.text == confermPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        // show error message
        showErrorMessage("Password don't match");
      }

      // pop the loading circle
      // ignore: use_build_context_synchronously
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      // ignore: use_build_context_synchronously
      // Navigator.pop(context);

      //   if (e.code == 'user-not-found') {
      //     wrongEmailMessage();
      //   } else if (e.code == 'wrong-password') {
      //     wrongPasswordMessage();
      //   } else if (e.code == 'invalid-credential') {
      //     wrongOtherMessage();
      //   }
      // }

      showErrorMessage(e.code);
    }
  }

  // void wrongEmailMessage() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const AlertDialog(
  //         title: Text("Incorrect Email"),
  //       );
  //     },
  //   );
  // }

  // void wrongPasswordMessage() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const AlertDialog(
  //         title: Text("Incorrect Password"),
  //       );
  //     },
  //   );
  // }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
            title: Text(message),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const SizedBox(
                  height: 30,
                ),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(
                  height: 30,
                ),

                //welcome back you've been missed
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                // user textfield
                MyTextfield(
                  controller: emailController,
                  hintText: "Username",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),

                // password textfield
                MyTextfield(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),

                // conferm password
                MyTextfield(
                  controller: confermPasswordController,
                  hintText: "Conterm Password",
                  obscureText: true,
                ),

                const SizedBox(
                  height: 25,
                ),

                // sign in button
                MyButton(
                  onTap: signUserUp,
                  text: "Sign Up",
                ),

                const SizedBox(
                  height: 50,
                ),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Text(
                        "Or continue with",
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // google + apple sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                        onTap: () => AuthService().singInWithGoogle(),
                        imagePath: "assets/images/google.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    SquareTile(
                        onTap: () {}, imagePath: "assets/images/apple.png"),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already register?",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "SignIn",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
