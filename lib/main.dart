import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/firebase_options.dart';
import 'package:pokedex_mobile/providers/category_provider.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_mobile/screens/category_screen.dart';
import 'package:pokedex_mobile/screens/pokemon_details.dart';
import 'package:pokedex_mobile/screens/pokemon_favorite_list.dart';
import 'package:pokedex_mobile/screens/pokemon_screen.dart';
import 'package:pokedex_mobile/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => PokemonProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
      ],
      child: MaterialApp(
        title: 'Pokedex',
        home: AppRootWidget(),
        routes: {
          '/category': (context) => CategoryScreen(),
          '/pokemon': (context) => PokemonScreenWidget(),
          '/favorites': (context) => PokemonFavoriteListScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
        },
      ),
    );
  }
}

class AppRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.isLoggedIn) {
      return MainWidget();
    } else {
      return LoginScreen();
    }
  }
}

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int _selectedIndex = 0;

  final List<Widget> _mainWidgets = [
    CategoryScreen(),
    PokemonScreenWidget(),
    PokemonFavoriteListScreen(),
  ];

  void _onItemTapped(int index) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    if (index == 3) {
      if (loginProvider.isLoggedIn) {
        loginProvider.logout();
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final isLogged = loginProvider.isLoggedIn;

    return Scaffold(
      body: _mainWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Pokemons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(isLogged ? Icons.logout : Icons.login),
            label: isLogged ? 'Log Out' : 'Login',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
