import 'package:flutter/material.dart';
import '../src/pages/login_page.dart';
import '../src/pages/admin_page.dart';
import '../src/pages/credencial_page.dart';
import '../src/pages/init.dart';
import '../src/pages/mis_reservas_page.dart';
import '../src/pages/perfil_page.dart';
import '../src/pages/reserva_page.dart';
import '../src/pages/select_plan_page.dart';
import '../src/pages/signup_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    'signup': (BuildContext context) => const SignUpPage(),
    'login': (BuildContext context) => const LoginPage(),
    'credencial': (BuildContext context) => const MiCredencialPage(),
    'admin': (BuildContext context) => const AdminPage(),
    'home': (BuildContext context) => const BottomBar(),
    'selectPlan': (BuildContext context) => const SelectPlanPage(),
    'ScheduledClasses': (BuildContext context) => ScheduledClassesPage(),
    'userProfile': (BuildContext context) => const UserProfilePage(),
    'programacionClases': (BuildContext context) => const ProgramacionClasesPage(),



        };
}
