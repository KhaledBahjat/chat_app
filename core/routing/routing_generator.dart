import 'package:chat_app/views/auth/sign_in_view.dart';
import 'package:go_router/go_router.dart';

import 'app_routs.dart';

class RoutingGenerator{
  static GoRouter goRouter =GoRouter(
  routes: [
    GoRoute(path: AppRouts.signInView,
        name: AppRouts.signInView,
        builder: ( context,  state) =>SignInView()),
  ],
      initialLocation: AppRouts.signInView
  );
}