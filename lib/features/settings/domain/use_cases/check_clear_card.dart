import 'package:theka_task/features/settings/domain/repository/cashed_credit_card.dart';

class CashCreditUseCase {
  final CreditCardRepository creditCardRepository;
  CashCreditUseCase({required this.creditCardRepository});
  Future call() async {
    return await creditCardRepository.deleteAllDocuments();
  }
}
