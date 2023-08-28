import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/firebase_options.dart';
import 'package:pokedex_mobile/providers/category_provider.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/screens/pokemon_details.dart';
import 'package:pokedex_mobile/screens/pokemon_favorite_list.dart';
import 'package:pokedex_mobile/screens/pokemon_screen.dart';
import 'package:provider/provider.dart';
import 'screens/category_screen.dart';
import 'package:pokedex_mobile/widgets/login.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
            initialRoute: MainWidget.routeName,
            routes: {
              MainWidget.routeName: (context) => const MainWidget(),
              PokemonDetailsScreen.routeName: (context) =>
                  const PokemonDetailsScreen(),
              LoginScreen.routeName: (context) => LoginScreen(),
            }));
  }
}

class MainWidget extends StatefulWidget {
  static const routeName = '/';

  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int _selectIndex = 0;

  final Map<int, Widget> _mainWidgets = {
    0: const CategoryScreen(),
    1: const PokemonScreenWidget(),
    2: const PokemonFavoriteListScreen(),
  };

  void _onTapItem(int index) {
    if (index == 3) {
      // Navegar a la pantalla de inicio de sesión
      Navigator.of(context).pushNamed(LoginScreen.routeName);
    } else {
      setState(() {
        _selectIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainWidgets[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categorias'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Pokemons'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Login'),
        ],
        currentIndex: _selectIndex,
        onTap: _onTapItem,
      ),
    );
  }
}
