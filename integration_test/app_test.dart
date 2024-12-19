import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tractian_challenge/main.dart';
import 'package:tractian_challenge/ui/asset/widgets/asset_page.dart';
import 'package:tractian_challenge/ui/asset/widgets/tree_list_item.dart';
import 'package:tractian_challenge/ui/home/widgets/company_button.dart';
import 'package:tractian_challenge/ui/home/widgets/home_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('It should load app', (WidgetTester tester) async {
      // Given
      await tester.pumpWidget(MyApp());

      // When
      await tester.pumpAndSettle();

      // Then
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(CompanyButton), findsAtLeast(3));
    });

    testWidgets(
        'It should load all companies and navigate to respective assets page',
        (WidgetTester tester) async {
      // Given
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Find Jaguar button and tap
      await tester.tap(find.text('Jaguar'));
      await tester.pumpAndSettle();

      expect(find.byType(AssetPage), findsOneWidget);
      expect(find.byType(TreeListItem), findsWidgets);

      // Go back to home page
      await tester.tap(find.backButton());
      await tester.pumpAndSettle();

      // Find Tobias button and tap
      await tester.tap(find.text('Tobias'));
      await tester.pumpAndSettle();

      expect(find.byType(AssetPage), findsOneWidget);
      expect(find.byType(TreeListItem), findsWidgets);

      // Go back to Home page
      await tester.tap(find.backButton());
      await tester.pumpAndSettle();

      // Find Apex button and tap
      await tester.tap(find.text('Apex'));
      await tester.pumpAndSettle();

      expect(find.byType(AssetPage), findsOneWidget);
      expect(find.byType(TreeListItem), findsWidgets);
    });
  });
}
