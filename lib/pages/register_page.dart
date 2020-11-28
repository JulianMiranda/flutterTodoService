import 'package:flutter/material.dart';

import 'package:cotopaxi/widgets/logo.dart';
import 'package:cotopaxi/widgets/labels.dart';
import 'package:cotopaxi/widgets/custom_input.dart';
import 'package:cotopaxi/widgets/btn_blue.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height *1.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(title: 'Registro'),
                  _Form(),
                  Labels(route: 'login',title: '¿Ya tienes cuenta?', subtitle: 'Logueate',),
                  Text('Terminos y Condiciones',
                      style: TextStyle(fontWeight: FontWeight.w200)),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            palceholder: "Nombre",
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            palceholder: "Email",
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            palceholder: "Password",
            isPassword: true,
            textController: passCtrl,
          ),
          BtnBlue(
            text: 'Ingrese',
            onPressed: () {
              print(emailCtrl.text);
              print(passCtrl.text);
            },
          )
        ],
      ),
    );
  }
}
