import 'package:flutter/material.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/login_screen.dart';
import 'package:loja/tile/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  Widget _buildeDrawerBack() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildeDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Text(
                        "Flutter's\nCloathing",
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          return  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Ola, ${!model.isLoggedIn() ? " " : model.userData["name"]}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if(!model.isLoggedIn()){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                                  }else{
                                   model.signOut();
                                  }
                                },
                                child: Text(
                                  !model.isLoggedIn() ?
                                  'Entre ou cadastre-se >'
                                  : 'Sair',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          );
                        },
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Inicio", pageController,0),
              DrawerTile(Icons.list, "Produtos", pageController,1),
              DrawerTile(Icons.location_on, "Loja", pageController,2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageController,3),
            ],
          )
        ],
      ),
    );
  }
}
