import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:km_to_miles/screens/calc_screen.dart';
import 'package:km_to_miles/screens/converter_screen.dart';
import 'package:km_to_miles/screens/intro_screen.dart';
import 'package:km_to_miles/screens/prev_calc_list.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = [
      'Home',
      'Siple Calculator',
      'Converter',
      'Calc History'
    ];

    List<Widget> menuItems = [];
    menuItems.add(const DrawerHeader(
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: Text(
          'Aastalõputöö',
          style: TextStyle(color: Colors.white, fontSize: 28),
        )));
    menuTitles.forEach((String element) {
      Widget screen = Container();
      menuItems.add(ListTile(
        title: Text(element, style: const TextStyle(fontSize: 18)),
        onTap: () {
          switch (element) {
            case 'Home':
              screen = const IntroScreen();
              break;

            case 'Siple Calculator':
              screen = CalcScreen();
              break;

            case 'Converter':
              screen = ConverterScreen();
              break;
            case 'Calc History':
              screen = PrevCalcScreen();
              break;
          }
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => screen));
        },
      ));
    });
    return menuItems;
  }
}
