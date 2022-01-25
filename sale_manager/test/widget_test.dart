import 'package:flutter_test/flutter_test.dart';

import 'package:sale_manager/providers/counter_provider.dart';
import 'package:sale_manager/screens/info.dart';

void main() {
  test('Test counter incrementing', () async {
   final cnt = Counter();
   cnt.increment();
   expect(cnt.count, 1);
  });

  testWidgets('Test of Infos screen', (WidgetTester tester) async {

    await tester.pumpWidget(
        Infos()
    );
    await tester.pumpAndSettle();
    final finder = find.text("Infos about");
    expect(finder, findsOneWidget);
    final text = find.text("This is a flutter project at University of Szeged.");
    expect(text, findsOneWidget);
    var button = find.text("Leave a comment");
    expect(button, findsOneWidget);
  }

  );
}
