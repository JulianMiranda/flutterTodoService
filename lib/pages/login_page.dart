import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cotopaxi/widgets/logo.dart';
import 'package:cotopaxi/widgets/labels.dart';
import 'package:cotopaxi/widgets/custom_input.dart';
import 'package:cotopaxi/widgets/btn_blue.dart';
import 'package:cotopaxi/services/aut_service.dart';
import 'package:cotopaxi/helpers/show_alert.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(
                    title: 'Cotopaxi',
                  ),
                  _Form(),
                  Labels(
                    route: 'register',
                    title: '¿No tienes cuenta?',
                    subtitle: 'Crear cuenta',
                  ),
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
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
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
            onPressed: authService.sennding
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginReq = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());
                    if (loginReq) {
                      // TODO navegar
                      Navigator.pushReplacementNamed(context, 'user');
                    } else {
                      showAlert(
                          context, 'Login incorrecto', 'Revise credenciales');
                    }
                  },
          )
        ],
      ),
    );
  }
}
