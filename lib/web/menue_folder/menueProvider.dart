import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  VoidCallback? press;
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int get selectedIndex => _selectedIndex;
  saveIndex(index, VoidCallback p) {
    _selectedIndex = index;
    // p = press!;
    press = p;
    notifyListeners();
  }

  // GlobalKey<ScaffoldState> get scaffoldkey => _scaffoldKey;

  // void openOrCloseDraw() {
  //   if (_scaffoldKey.currentState!.isDrawerOpen) {
  //     _scaffoldKey.currentState!.openEndDrawer();
  //   } else {
  //     _scaffoldKey.currentState!.openDrawer();
  //   }
  //   print("PPPPPPPPPPPPPPPPPPPPPPPPP");
  //   notifyListeners();
  // }

  List<String> get menuItems => [
        "Home",
        "Contact",
        "Transactions",
        "Profile",
        'About us',
        'Contact us',
      ];

  // List<MaterialPageRoute> menuRoute =[
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => Profile ))
  // ];
  List<Icon> get menuIcons => [
        Icon(
          Icons.home,
          color: Colors.amber,
        ),
        Icon(Icons.message, color: Colors.amber),
        Icon(Icons.compare_arrows_outlined, color: Colors.amber),
        Icon(Icons.person, color: Colors.amber),
        Icon(Icons.info_outline, color: Colors.amber),
        Icon(Icons.group, color: Colors.amber)
      ];
}
