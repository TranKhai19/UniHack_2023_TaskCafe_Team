import 'package:auto_route/auto_route.dart';
import 'package:unihack/router/auto_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: HomeViewRoute.page,
      children: [
        RedirectRoute(path: '', redirectTo: 'Home'),
        AutoRoute(path: 'Home', page: HomeRoute.page),
        AutoRoute(path: 'Profile', page: ProfileRoute.page),
        AutoRoute(path: 'LogIn', page: LogInRoute.page),
        // AutoRoute(page: 'History', page: History.page),
        AutoRoute(path: 'Tool', page: Tool.page),
        AutoRoute(path: 'History', page: History.page),
      ],
    ),
    AutoRoute(path: '/LogIn', page: LogInRoute.page),
    AutoRoute(path: '/ForgotPassWord', page: ForgotPasswordRoute.page),
    AutoRoute(path: '/Register', page: RegisterRoute.page),
     AutoRoute(path: '/Addtask', page:  Addtask.page),
    AutoRoute(path: '/Search', page:  Search.page),
    AutoRoute(path: '/Post/:id', page: Post.page),
    AutoRoute(path: '/Event/:id', page: Event.page),
  ];
}
