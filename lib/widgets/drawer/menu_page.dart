import 'package:aventones/widgets/drawer/circular_image.dart';
import 'package:aventones/widgets/drawer/zoom_scaffold.dart';
import 'package:aventones/res/company_colors.dart';
import 'package:aventones/tmp/google_maps_test.dart';
import 'package:aventones/routes/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aventones/tmp/test.dart';
import 'package:aventones/routes/facebook_login.dart';

class MenuScreen extends StatelessWidget {
  final String imageUrl =
      "https://graph.facebook.com/1244336338/picture?type=normal";

  final List<MenuItem> options = [
    MenuItem(Icons.search, 'Buscar un viaje (Map Sample)', MapSample()),
    MenuItem(Icons.add, 'Publicar un viaje', PostScreen()),
    MenuItem(Icons.directions_car, 'Mis viajes', SecondRoute()),
    MenuItem(Icons.mail, 'Mensajes', SecondRoute()),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        //on swiping left
        if (details.delta.dx < -6) {
          Provider.of<MenuController>(context, listen: true).toggle();
        }
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 64,
            left: 16,
            bottom: 16,
            right: MediaQuery.of(context).size.width / 2.9),
        color: CompanyColors.customBlack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: CircularImage(
                    NetworkImage(imageUrl),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child:  Text(
                    'Esteban Flores',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ),
                SizedBox(height: 8),
                Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child:  Text(
                      'Bienvenido a aventones!',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    )
                ),
              ],
            ),
            SizedBox(height: 32),
            // ;
            Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: CompanyColors.customWhite,
                    size: 20,
                  ),
                  title: Text(
                    "Inicio",style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Provider.of<MenuController>(context, listen: true).toggle();
                  },
                  dense: true,
                )
              ],
            ),
            Column(
              children: options.map((item) {
                return ListTile(
                  leading: Icon(
                    item.icon,
                    color: CompanyColors.customWhite,
                    size: 20,
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => item.className),
                    );
                  },
                  dense: true,
                );
              }).toList(),
            ),
            Spacer(),
            ListTile(
              onTap: () {
                Provider.of<MenuController>(context, listen: true).toggle();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
              leading: Icon(
                Icons.settings,
                color: CompanyColors.customWhite,
                size: 20,
              ),
              title: Text('Configuración'),
              dense: true,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FacebookLoginScreen()),
                );
              },
              leading: Icon(
                Icons.exit_to_app,
                color: CompanyColors.customWhite,
                size: 20,

              ),
              title: Text('Cerrar sesión',
                  style: TextStyle(fontSize: 14)),
              dense: true,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;
  var className;

  MenuItem(this.icon, this.title, this.className);
}
