import 'package:theka_task/features/settings/data/data_source/local_data_source.dart';
import 'package:theka_task/features/settings/data/model/credit_card_model.dart';
import 'package:theka_task/features/settings/domain/entities/card_details.dart';
import 'package:theka_task/features/settings/domain/repository/cashed_credit_card.dart';

class CashedCardsRepositoryImpl implements CreditCardRepository {
  final LocalDataSource localDataSource;
  CashedCardsRepositoryImpl({required this.localDataSource});

  @override
  Future addCardDetailsToLocal(CardEntities cardEntities) {
    final List<CardModel> cardModel = []..add(CardModel(
        cvs: cardEntities.cvs,
        date: cardEntities.date,
        name: cardEntities.name,
        number: cardEntities.number));

    return localDataSource.cacheCredit(cardModel);
  }

  @override
  Future<void> deleteAllDocuments() async {
    return await localDataSource.deleteAllDocuments();
  }
}
