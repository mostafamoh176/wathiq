import 'package:theka_task/features/settings/domain/entities/card_details.dart';
import 'package:theka_task/features/settings/domain/repository/cashed_credit_card.dart';

class CashCreditDataUseCase {
  final CreditCardRepository creditCardRepository;
  CashCreditDataUseCase({required this.creditCardRepository});

  Future call({required CardEntities cardEntities}) async {
    return await creditCardRepository.addCardDetailsToLocal(cardEntities);
  }
}
