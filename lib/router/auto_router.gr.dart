// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:unihack/bloc/authentication/authentication_bloc.dart' as _i15;
import 'package:unihack/screens/authentication/forgot_password_screen.dart'
    as _i1;
import 'package:unihack/screens/authentication/login_screen.dart' as _i2;
import 'package:unihack/screens/authentication/register_screen.dart' as _i3;
import 'package:unihack/screens/event/addTask/AddTask.dart' as _i4;
import 'package:unihack/screens/event/event.dart' as _i5;
import 'package:unihack/screens/history/history.dart' as _i6;
import 'package:unihack/screens/home/home_screen.dart' as _i7;
import 'package:unihack/screens/home_view_screen.dart' as _i8;
import 'package:unihack/screens/post/post.dart' as _i9;
import 'package:unihack/screens/profile/profile_screen.dart' as _i10;
import 'package:unihack/screens/Search/Search.dart' as _i12;
import 'package:unihack/screens/tool/tool.dart' as _i11;

abstract class $AppRouter extends _i13.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    ForgotPasswordRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ForgotPasswordScreen(),
      );
    },
    LogInRoute.name: (routeData) {
      final args = routeData.argsAs<LogInRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.LogInScreen(
          key: args.key,
          authenticationBloc: args.authenticationBloc,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterScreen(),
      );
    },
    Addtask.name: (routeData) {
      final args = routeData.argsAs<AddtaskArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.Addtask(
          key: args.key,
          id: args.id,
        ),
      );
    },
    Event.name: (routeData) {
      final args = routeData.argsAs<EventArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.Event(
          key: args.key,
          id: args.id,
        ),
      );
    },
    History.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.History(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomeScreen(),
      );
    },
    HomeViewRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.HomeViewScreen(),
      );
    },
    Post.name: (routeData) {
      final args = routeData.argsAs<PostArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.Post(
          key: args.key,
          id: args.id,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ProfileScreen(),
      );
    },
    Tool.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.Tool(),
      );
    },
    Search.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.Search(),
      );
    },
  };
}

/// generated route for
/// [_i1.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i13.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LogInScreen]
class LogInRoute extends _i13.PageRouteInfo<LogInRouteArgs> {
  LogInRoute({
    _i14.Key? key,
    required _i15.AuthenticationBloc authenticationBloc,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          LogInRoute.name,
          args: LogInRouteArgs(
            key: key,
            authenticationBloc: authenticationBloc,
          ),
          initialChildren: children,
        );

  static const String name = 'LogInRoute';

  static const _i13.PageInfo<LogInRouteArgs> page =
      _i13.PageInfo<LogInRouteArgs>(name);
}

class LogInRouteArgs {
  const LogInRouteArgs({
    this.key,
    required this.authenticationBloc,
  });

  final _i14.Key? key;

  final _i15.AuthenticationBloc authenticationBloc;

  @override
  String toString() {
    return 'LogInRouteArgs{key: $key, authenticationBloc: $authenticationBloc}';
  }
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterRoute extends _i13.PageRouteInfo<void> {
  const RegisterRoute({List<_i13.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i4.Addtask]
class Addtask extends _i13.PageRouteInfo<AddtaskArgs> {
  Addtask({
    _i14.Key? key,
    required String id,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          Addtask.name,
          args: AddtaskArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'Addtask';

  static const _i13.PageInfo<AddtaskArgs> page =
      _i13.PageInfo<AddtaskArgs>(name);
}

class AddtaskArgs {
  const AddtaskArgs({
    this.key,
    required this.id,
  });

  final _i14.Key? key;

  final String id;

  @override
  String toString() {
    return 'AddtaskArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i5.Event]
class Event extends _i13.PageRouteInfo<EventArgs> {
  Event({
    _i14.Key? key,
    required String id,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          Event.name,
          args: EventArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'Event';

  static const _i13.PageInfo<EventArgs> page = _i13.PageInfo<EventArgs>(name);
}

class EventArgs {
  const EventArgs({
    this.key,
    required this.id,
  });

  final _i14.Key? key;

  final String id;

  @override
  String toString() {
    return 'EventArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i6.History]
class History extends _i13.PageRouteInfo<void> {
  const History({List<_i13.PageRouteInfo>? children})
      : super(
          History.name,
          initialChildren: children,
        );

  static const String name = 'History';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomeScreen]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i8.HomeViewScreen]
class HomeViewRoute extends _i13.PageRouteInfo<void> {
  const HomeViewRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeViewRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i9.Post]
class Post extends _i13.PageRouteInfo<PostArgs> {
  Post({
    _i14.Key? key,
    required String id,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          Post.name,
          args: PostArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'Post';

  static const _i13.PageInfo<PostArgs> page = _i13.PageInfo<PostArgs>(name);
}

class PostArgs {
  const PostArgs({
    this.key,
    required this.id,
  });

  final _i14.Key? key;

  final String id;

  @override
  String toString() {
    return 'PostArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i10.ProfileScreen]
class ProfileRoute extends _i13.PageRouteInfo<void> {
  const ProfileRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i11.Tool]
class Tool extends _i13.PageRouteInfo<void> {
  const Tool({List<_i13.PageRouteInfo>? children})
      : super(
          Tool.name,
          initialChildren: children,
        );

  static const String name = 'Tool';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i12.Search]
class Search extends _i13.PageRouteInfo<void> {
  const Search({List<_i13.PageRouteInfo>? children})
      : super(
          Search.name,
          initialChildren: children,
        );

  static const String name = 'Search';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}
