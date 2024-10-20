import 'package:flutter/material.dart';
import '../src/pages/login_page.dart';
import '../src/pages/admin_page.dart';
import '../src/pages/credencial_page.dart';
import '../src/pages/my_home_page.dart';
import '../src/pages/perfil_page.dart';
import '../src/pages/select_plan_page.dart';
import '../src/pages/signup_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    'signup': (BuildContext context) => const SignUpPage(),
    'login': (BuildContext context) => const LoginPage(),
    'credencial': (BuildContext context) => const MiCredencialPage(),
    'admin': (BuildContext context) => const AdminPage(),
    'home': (BuildContext context) => const MyHomePage(),
    'selectPlan': (BuildContext context) => const SelectPlanPage(),
    'userProfile': (BuildContext context) => UserProfilePage(),


        };
}
