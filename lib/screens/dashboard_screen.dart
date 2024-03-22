import 'package:app01/network/sesionId_tmdb.dart';
import 'package:app01/screens/login_screen.dart';
import 'package:app01/settings/app_valuenotifier.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'),),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150')
              ),
              accountName: Text('Andrés Tamayo Martínez'),
              accountEmail: Text('19030296@itcelaya.edu.mx')
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('Práctica 1'),
              subtitle: Text('Aqui iria la descripcion si tuviera una'),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text("Mi despensa"),
              subtitle: Text("Relacion de productos que no voy a usar"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(context, "/despensa"),
            ),
            ListTile( //Se utiliza para manejar titulos y subtitulos en cada elemento, ademas de tener cosas a los lados
              leading: Icon(Icons.movie),
              title: Text("Moviles app"),
              subtitle: Text("Consulta de peliculas particulares"),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                SessionID().getSessionId();
                Navigator.pushNamed(context, "/movies");
              },
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Salir'),
              subtitle: Text('Hasta luego'),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
            DayNightSwitcher(
              isDarkModeEnabled: AppValueNotifier.banTheme.value,
              onStateChanged: (isDarkModeEnabled) {
                AppValueNotifier.banTheme.value = isDarkModeEnabled;
              },
            ),
          ],
        ),
      ),
    );
  }
}