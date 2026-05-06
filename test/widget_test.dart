import 'package:portfolio_raven/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App loads and shows intro text', (WidgetTester tester) async {
    // Load your app
    await tester.pumpWidget(const PortfolioApp());
  });
}
