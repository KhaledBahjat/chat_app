import 'package:chat_app/core/routing/app_routs.dart';
import 'package:chat_app/views/auth/register_view.dart';
import 'package:chat_app/views/auth/sign_in_view.dart';
import 'package:chat_app/views/home/home_view.dart';
import 'package:go_router/go_router.dart';

class RoutingGenerator {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRouts.signInView,
    routes: [
      GoRoute(
        path: AppRouts.signInView,
        name: AppRouts.signInView,
        builder: (context, state) => SignInView(),
      ),
      GoRoute(
        path: AppRouts.registerView,
        name: AppRouts.registerView,
        builder: (context, state) => RegisterView(),
      ),
      GoRoute(
        path: AppRouts.homeView,
        name: AppRouts.homeView,
        builder: (context, state) => HomeView(),
      ),
    ],
  );
}
