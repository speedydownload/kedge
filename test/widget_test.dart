import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ballast/app.dart';

void main() {
  testWidgets('app boots to the empty home state', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: BallastApp()));
    await tester.pumpAndSettle();

    expect(find.text('Nothing blocked yet.'), findsOneWidget);
    expect(find.text('Start a block'), findsOneWidget);
  });
}
