import 'package:easymove/features/homescreen/presentation/pages/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('home screen renders key sections', (WidgetTester tester) async {
    await tester.pumpWidget(const HomeScreen());

    expect(find.text('Featured Listings'), findsOneWidget);
    expect(find.text('Categories of Properties'), findsOneWidget);
    expect(find.text('Packers & Movers'), findsOneWidget);
    expect(find.text('Flights'), findsOneWidget);
  });
}
