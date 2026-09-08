import 'package:flutter_test/flutter_test.dart';

import 'package:passaaqui_mobile_flutter/app/app.dart';

void main() {
  testWidgets('App loads home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('PassaAqui'), findsOneWidget);
  });
}
