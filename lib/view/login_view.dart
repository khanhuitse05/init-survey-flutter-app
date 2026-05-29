import 'package:flutter/material.dart';
import 'package:initsurvey/core/cconfig.dart';
import 'package:initsurvey/locale/app_translations.dart';
import 'package:initsurvey/model/user.dart';
import 'package:initsurvey/repository/login_repository.dart';
import 'package:initsurvey/ui/button/gradient_submit.dart';
import 'package:initsurvey/ui/form/validators.dart';
import 'package:initsurvey/ui/utility/app_snackbar.dart';
import 'package:initsurvey/ui/utility/pattern.dart';
import 'package:initsurvey/ui/utility/progress_dialog.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _showPassword = false;

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PatternTop(),
          Container(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/ui/bottom.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
            alignment: Alignment.center,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (_) {
                FocusScope.of(context).unfocus();
              },
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppTranslations.of(context).text('login_title'),
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.account_box),
                          labelText:
                              AppTranslations.of(context).text('username'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'The username is invalid.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          username = value ?? '';
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            labelText:
                                AppTranslations.of(context).text('password'),
                            suffixIcon: IconButton(
                              icon: Icon(_showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                            )),
                        obscureText: _showPassword,
                        validator: Validators.password,
                        onSaved: (value) {
                          password = value ?? '';
                        },
                      ),
                      const SizedBox(height: 30),
                      Container(
                        alignment: Alignment.centerRight,
                        child: GradientButton(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  AppTranslations.of(context)
                                      .text('submit')
                                      .toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          onPressed: onLogin,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onLogin() async {
    setState(() {
      _autoValidate = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showLoading(context);
      final result = await LoginRepository.login(username, password);
      hideLoading(context);
      if (result['status'] == 'success') {
        Config.instance.saveToken(result['message']);
        Config.instance.saveUser(User(username: username, password: password));
        await Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(mySnackBar(result['message']));
      }
    }
  }
}
