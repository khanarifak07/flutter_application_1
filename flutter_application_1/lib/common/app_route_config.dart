// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:otobids_evaluations_app/Forms/2W/two_wheeler_primary_form.dart';
// import 'package:otobids_evaluations_app/Forms/2W/two_wheeler_secondary_form.dart';
// import 'package:otobids_evaluations_app/Forms/4W/four_wheeler_primary_form.dart';
// import 'package:otobids_evaluations_app/Forms/4W/four_wheeler_secondary_form.dart';
// import 'package:otobids_evaluations_app/Forms/CE/ce_primary_form.dart';
// import 'package:otobids_evaluations_app/Forms/CE/ce_secondary_form.dart';
// import 'package:otobids_evaluations_app/Forms/CV/cv_primary_form.dart';
// import 'package:otobids_evaluations_app/Forms/CV/cv_secondary_form.dart';
// import 'package:otobids_evaluations_app/auth/login_page.dart';
// import 'package:otobids_evaluations_app/change-password/change_password.dart';
// import 'package:otobids_evaluations_app/common/router/app_route_const.dart';
// import 'package:otobids_evaluations_app/common/utilities.dart';
// import 'package:otobids_evaluations_app/dashboard/dashboard.dart';
// import 'package:otobids_evaluations_app/select-vehicle-type/select_vehicle_type_tabs.dart';
// import 'package:otobids_evaluations_app/splash_screen.dart';

// GoRouter goRouter = GoRouter(
//   initialLocation: '/${AppRouteConst.splashScreen}',
//   observers: [TestNavigationObserver()],
//   routes: [
//     GoRoute(
//       path: '/${AppRouteConst.splashScreen}',
//       name: AppRouteConst.splashScreen,
//       builder: (context, state) => const SplashScreen(),
//     ),
//     GoRoute(
//       path: '/${AppRouteConst.login}',
//       name: AppRouteConst.login,
//       builder: (context, state) => const LoginPage(),
//     ),
//     GoRoute(
//       path: '/${AppRouteConst.changePassword}',
//       name: AppRouteConst.changePassword,
//       builder: (context, state) => const ChangePassword(),
//     ),
//     GoRoute(
//       path: '/${AppRouteConst.dashboard}',
//       name: AppRouteConst.dashboard,
//       builder: (context, state) => const Dashboard(),
//       routes: [
//         GoRoute(
//           path: AppRouteConst.selectVehicleType,
//           name: AppRouteConst.selectVehicleType,
//           builder: (context, state) => const SelectVehicleTypeTabs(),
//         ),
//         GoRoute(
//           path: '${AppRouteConst.twoWheelerPrimaryForm}/:number',
//           name: AppRouteConst.twoWheelerPrimaryForm,
//           builder: (context, state) {
//             final vehicleRegistrationNo = state.pathParameters['number']!;
//             return TwoWheelerPrimaryForm(
//                 vehicleRegistrationNumber: vehicleRegistrationNo);
//           },
//           routes: [
//             GoRoute(
//               path: AppRouteConst.twoWheelerSecondaryForm,
//               name: AppRouteConst.twoWheelerSecondaryForm,
//               builder: (context, state) {
//                 final vehicleRegistrationNo = state.pathParameters['number']!;
//                 return TwoWheelerSecondaryForm(
//                     vehicleRegistrationNumber: vehicleRegistrationNo);
//               },
//             ),
//           ],
//         ),
//         GoRoute(
//           path: '${AppRouteConst.fourWheelerPrimaryForm}/:number',
//           name: AppRouteConst.fourWheelerPrimaryForm,
//           builder: (context, state) {
//             final vehicleRegistrationNo = state.pathParameters['number']!;
//             return FourWheelerPrimaryForm(
//                 vehicleRegistrationNumber: vehicleRegistrationNo);
//           },
//           routes: [
//             GoRoute(
//               path: AppRouteConst.fourWheelerSecondaryForm,
//               name: AppRouteConst.fourWheelerSecondaryForm,
//               builder: (context, state) {
//                 final vehicleRegistrationNo = state.pathParameters['number']!;
//                 return FourWheelerSecondaryForm(
//                     vehicleRegistrationNumber: vehicleRegistrationNo);
//               },
//             ),
//           ],
//         ),
//         GoRoute(
//           path: '${AppRouteConst.cvPrimaryForm}/:number',
//           name: AppRouteConst.cvPrimaryForm,
//           builder: (context, state) {
//             final vehicleRegistrationNo = state.pathParameters['number']!;
//             return CVPrimaryForm(
//                 vehicleRegistrationNumber: vehicleRegistrationNo);
//           },
//           routes: [
//             GoRoute(
//               path: AppRouteConst.cvSecondaryForm,
//               name: AppRouteConst.cvSecondaryForm,
//               builder: (context, state) {
//                 final vehicleRegistrationNo = state.pathParameters['number']!;
//                 return CVSecondaryForm(
//                     vehicleRegistrationNumber: vehicleRegistrationNo);
//               },
//             ),
//           ],
//         ),
//         GoRoute(
//           path: '${AppRouteConst.cePrimaryForm}/:number',
//           name: AppRouteConst.cePrimaryForm,
//           builder: (context, state) {
//             final vehicleRegistrationNo = state.pathParameters['number']!;
//             return CEPrimaryForm(
//                 vehicleRegistrationNumber: vehicleRegistrationNo);
//           },
//           routes: [
//             GoRoute(
//               path: AppRouteConst.ceSecondaryForm,
//               name: AppRouteConst.ceSecondaryForm,
//               builder: (context, state) {
//                 final vehicleRegistrationNo = state.pathParameters['number']!;
//                 return CESecondaryForm(
//                     vehicleRegistrationNumber: vehicleRegistrationNo);
//               },
//             ),
//           ],
//         ),
//       ],
//     ),
//   ],
// /*   redirect: (context, state) async {
//     final token = await Utilities.getAuthToken();
//     final isGoingToLogin = state.path == '/${AppRouteConst.login}';

//     // If the user is not authenticated and trying to access a protected route
//     if (token == null && !isGoingToLogin) {
//       return '/${AppRouteConst.login}';
//     }

//     // If the user is authenticated and trying to access the login page, redirect to the dashboard
//     if (token != null && isGoingToLogin) {
//       return '/${AppRouteConst.dashboard}';
//     }

//     return null;
//   }, */
// );

// class TestNavigationObserver extends RouteObserver {
//   @override
//   void didPop(Route route, Route? previousRoute) {
//     log("Route Popped from: ${previousRoute?.settings.name}, to: ${route.settings.name}");
//   }

//   @override
//   void didPush(Route route, Route? previousRoute) {
//     Utilities.getAuthToken().then((token) {
//       final isGoingToLogin = route.settings.name == AppRouteConst.login;
//       // log("Route Name ${route.settings.name}");
//       // log("Is Going to login $isGoingToLogin");
//       // log("Token $token");
//       // log("Condition ${token != null && isGoingToLogin}");
//       if (token != null && isGoingToLogin) {
//         navigator?.context.goNamed(AppRouteConst.dashboard);
//       }
//     });

//     log("Route Pushed From ${previousRoute?.settings.name} to ${route.settings.name}");
//   }

//   @override
//   void didRemove(Route route, Route? previousRoute) {
//     log("Route removed from: ${previousRoute?.settings.name}, to: ${route.settings.name}");
//   }

//   @override
//   void didReplace({Route? newRoute, Route? oldRoute}) {
//     log("Route replace from: ${oldRoute?.settings.name}, to: ${newRoute?.settings.name}");
//   }
// }
