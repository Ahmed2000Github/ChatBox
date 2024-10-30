
import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/presentation/views/not_found.dart';
import 'package:chat_box/presentation/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

AnimationController getAnimationController(WidgetTester tester){
  return  AnimationController(
      duration: const Duration(milliseconds: 0), // No animation for testing
      vsync: tester as TickerProvider,
    );
}
void main(){

  test("route shoud PageRouteBuilder", (){
    // Arrange
    // Act
    final route = AppRoutes.generateRoute(RouteSettings(name: '/unknown'));
    // Assert
    expect(route, isA<PageRouteBuilder>());
  });

  testWidgets("route shoud return a not found page when path is wrang", (WidgetTester tester)async{
    // Arrange
    final route = AppRoutes.generateRoute(const RouteSettings(name: "/unkownPath"));
    // Act
    final PageRouteBuilder<dynamic> pageRoute = route as PageRouteBuilder<dynamic>;
     await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body:  Builder(
          builder: (context) {
            // Use the pageBuilder to get the widget for the route
            final page = pageRoute.pageBuilder(context, getAnimationController(tester), getAnimationController(tester));
            return page; // Return the page as a child of the Scaffold
          },
        ),
      ),
    ));
    // Assert
     expect(find.byType(NotFound), findsExactly(1));
  });

   testWidgets('Generate route for welcome', (WidgetTester tester) async {
    // Arrange
    final route = AppRoutes.generateRoute(RouteSettings(name: AppRoutes.welcome));
    // Act
    final PageRouteBuilder<dynamic> pageRoute = route as PageRouteBuilder<dynamic>;
     await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body:  Builder(
          builder: (context) {
            // Use the pageBuilder to get the widget for the route
            final page = pageRoute.pageBuilder(context, getAnimationController(tester), getAnimationController(tester));
            return page; // Return the page as a child of the Scaffold
          },
        ),
      ),
    ));
    // Assert
    expect(find.byType(Welcome), findsOneWidget);
  });

}