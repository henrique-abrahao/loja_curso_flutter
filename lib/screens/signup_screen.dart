import 'package:flutter/material.dart';
import 'package:loja/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  final _scaffoldFey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldFey,
        appBar: AppBar(
          title: Text('Criar Conta'),
          centerTitle: true,
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: 'Nome Completo'),
                  controller: _nameController,
                  validator: (text) {
                    if (text.isEmpty) return "E-mail inválido";
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@"))
                      return "Nome inválido";
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(hintText: 'Senha'),
                  validator: (text) {
                    if (text.isEmpty || text.length < 6) {
                      return "Senha invalida";
                    }
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(hintText: 'Endereço'),
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Endereço invalida";
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    child: Text(
                      'Criar Conta',
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Map<String, dynamic> userData = {
                        "name": _nameController.text,
                        "email": _emailController.text,
                        "address": _addressController.text
                      };

                      if (_formKey.currentState.validate()) {
                        model.signUp(
                            userData: userData,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                      }
                    },
                  ),
                )
              ],
            ),
          );
        }));
  }

  void _onSuccess() {
    _scaffoldFey.currentState.showSnackBar(SnackBar(
      content: Text('Usuario inserido com sucesso!'),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));

    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldFey.currentState.showSnackBar(SnackBar(
      content: Text('Falha ao criar o usuário'),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
