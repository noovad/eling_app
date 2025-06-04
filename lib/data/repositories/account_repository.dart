import 'package:eling_app/data/eling_database.dart';
import 'package:eling_app/domain/entities/account/account.dart';

class AccountRepository {
  final ElingDatabase _database;

  AccountRepository({ElingDatabase? database})
    : _database = database ?? ElingDatabase.instance;

  Future<AccountEntity> createAccount(AccountEntity account) async {
    return _database.create<AccountEntity>(
      'accounts',
      account,
      (account) => account.toJson(),
    );
  }

  Future<List<AccountEntity>> getAccounts() async {
    final db = await _database.database;

    final accountsData = await db.query('accounts');

    return accountsData.map((json) => AccountEntity.fromJson(json)).toList();
  }

  Future<int> deleteAccount(String id) async {
    return _database.delete('accounts', id);
  }
}
