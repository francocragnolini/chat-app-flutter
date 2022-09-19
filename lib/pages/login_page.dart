import '../widgets/blue_button.dart';

import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';

import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/widgets/custom_input.dart';
import '../widgets/labels.dart';
import '../widgets/logo.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Logo(
                  title: "Messenger",
                ),
                _Form(),
                const Labels(
                  route: "register",
                  title: "Todavia no tienes una cuenta?",
                  subtitle: "Crear una Cuenta",
                ),
                const Text("Terminos y condicones de uso",
                    style: TextStyle(fontWeight: FontWeight.w200)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          //textField personalizado
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: "Email",
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: "Password",
            textController: passwordCtrl,
            isPassword: true,
          ),
          BlueButton(
              text: "Ingrese",
              onPressed: authService.autenticando
                  ? () => {}
                  : () async {
                      // saca el focus de donde este, cierra el teclado
                      FocusScope.of(context).unfocus();
                      print(emailCtrl.text);
                      print(passwordCtrl.text);
                      print(authService.autenticando);

                      final loginOk = await authService.login(
                          emailCtrl.text.trim(), passwordCtrl.text.trim());
                      if (loginOk) {
                        //TODO: navegar a otra pantalla
                      } else {
                        //Mostrar alerta
                        mostrarAlerta(context, "Login incorrecto",
                            "Revise sus credenciales nuevamente");
                      }
                    })
        ],
      ),
    );
  }
}
