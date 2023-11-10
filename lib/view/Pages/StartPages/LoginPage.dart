import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insergemobileapplication/controller/helper/management_helper.dart';
import 'package:insergemobileapplication/view/System/Settings/ProfileConstant.dart';

import 'ContactPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(defaultPadding),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90),
                      bottomRight: Radius.circular(90)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: SvgPicture.asset(
                        "assets/icons/InsergeSVGM.svg",
                        color: Colors.blueAccent,
                        height: 80,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(defaultLargePadding),
                child: Text(
                  'Inserge - Piura',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultLargePadding),
                child: Text(
                  'Ingenieria y Servicios Generales Piura S.A.C.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return "Ingresa un correo correcto";
                          } else {
                            return null;
                          }
                        },
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(defaultBorderRadius))),
                            focusColor: Colors.yellow,
                            hintText: "Correo Institucional",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                            )),
                      ),
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        cursorColor: Colors.amber,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ingresa una contraseña";
                          } else {
                            return null;
                          }
                        },
                        controller: _passwordController,
                        obscureText: !_isVisible,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(defaultBorderRadius))),
                            hintText: "Contraseña",
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            suffixIcon: GestureDetector(
                              child: Icon(
                                _isVisible
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye_rounded,
                              ),
                              onTap: () {
                                _isVisible = !_isVisible;
                                setState(() {});
                              },
                            )),
                      ),
                      const SizedBox(height: defaultPadding),
                      RawMaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius)),
                        fillColor: Colors.blueAccent,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            User? user = await UserManagement.loginUsingPass(
                                userd: _emailController.text,
                                pass: _passwordController.text,
                                context: context);
                            if (user != null) {
                              ScaffoldMessenger.of(this.context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Sesión iniciada"),
                              ));
                              Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(this.context)
                                  .showSnackBar(SnackBar(
                                content: const Text("Usuario incorrecto"),
                                action: SnackBarAction(
                                  label: 'Ok',
                                  onPressed: () {},
                                ),
                              ));
                            }
                          }
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Continuar",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("¿Problemas al acceder?",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              )),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ContactPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "  Contactanos",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
              ),
              //Usuario
            ],
          ),
        ),
      ),
    );
  }
}
