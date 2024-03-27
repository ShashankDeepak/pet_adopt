// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:adopt_pet/view/home/modals/animal_modal.dart';
import 'package:adopt_pet/view/home/widgets/animal_card_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Find if Cached Network Image is used or not',
      (WidgetTester tester) async {
    await tester.pumpWidget(AnimalCardTile(
      animalModal: AnimalModal(
          name: "Husky", species: "Dog", age: 12, price: 200, image: ""),
    ));
    var cachedNetworkImageFinder = find.byType(CachedNetworkImage);
    expect(cachedNetworkImageFinder, findsOne);
  });
}
