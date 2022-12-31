import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:assign3/main.dart';
import 'package:assign3/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  dynamic email = "";
  dynamic password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold),
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
                child: Text(
                  "Email Address",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white),
              margin: const EdgeInsets.only(bottom: 10.0),
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: emailController,
                onChanged: (value) => email = value,
                decoration: const InputDecoration(
                  hintText: "Enter your email",
                  border: InputBorder.none,
                  // filled: true,
                  // fillColor: Colors.grey,
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
                  child: Text(
                    "Password",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white),
              padding: const EdgeInsets.only(left: 10),
              margin: const EdgeInsets.only(bottom: 10.0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      const Text(
                        "Remember You",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () => {},
                        child: const Text(
                          "Forgot password",
                          style: TextStyle(color: Colors.white),
                        ))),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email, password: password);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyHomePage(title: "Movies")),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    if (kDebugMode) {
                      print('no user');
                    }
                  } else if (e.code == 'wrong password') {
                    if (kDebugMode) {
                      print('wrong password');
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
              child: const Text("Login"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Don't have an account",
                ),
                TextButton(
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signup()),
                          )
                        },
                    child: const Text(
                      "Signup",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ],
        ),
      )),
    );
  }
}
