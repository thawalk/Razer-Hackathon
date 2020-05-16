import 'package:save_spender/enums/account_type.dart';
import 'package:save_spender/models/bank_account_model.dart';
import 'package:save_spender/services/bank_service.dart';

class User {
  final String userId;
  String clientId;
  String clientKey;
  BankAccount wallet;
  BankAccount savings;

  User({this.userId});

  // TODO: Logic for generating Mambu Bank Accounts here

  // For demo purposes
  void demoStart() async {
    this.clientId = "976828389";
    this.clientKey = "8a8e87b772175ada01721e6e2d7d2c44";
    // Accounts pre-created on Mambu
    savings = BankAccount(
        accountId: "NKXG743",
        accountKey: "8a8e87b772175ada01721e73a1052c5d",
        balance: 0,
        accountType: AccountType.SAVINGS);
    wallet = BankAccount(
        accountId: "KQZE019",
        accountKey: "8a8e87b772175ada01721e7367bf2c59",
        balance: 0,
        accountType: AccountType.WALLET);
    // Update balances
    await savings.getBalance();
    await wallet.getBalance();
  }
}