import 'package:theka_task/features/settings/domain/entities/card_details.dart';

abstract class CreditCardRepository {
  Future addCardDetailsToLocal(CardEntities cardEntities);
  Future<void> deleteAllDocuments();
}
