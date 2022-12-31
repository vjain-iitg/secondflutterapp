import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'loginpage.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  dynamic email = "";
  dynamic password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Signup",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[700],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/movie.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Email Address",
                      style: TextStyle(color: Colors.white))),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white),
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: emailController,
                onChanged: (value) => email = value,
                decoration: const InputDecoration(
                  hintText: "Enter your email",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Text("Password", style: TextStyle(color: Colors.white))),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white),
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: passwordController,
                onChanged: (value) => password = value,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Enter your password",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    if (kDebugMode) {
                      print('Weak Password');
                    }
                  } else if (e.code == 'email-already-in-use') {
                    if (kDebugMode) {
                      print('Account exists');
                    }
                  }
                } catch (err) {
                  if (kDebugMode) {
                    print(err);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                minimumSize: const Size(350.0, 50.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Sign-up"),
            ),
          ],
        ),
      )),
    );
  }
}
