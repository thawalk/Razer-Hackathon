import 'package:save_spender/enums/account_type.dart';
import 'package:save_spender/exceptions/mambu_exception.dart';
import 'package:save_spender/services/bank_service.dart';

class BankAccount {
  String accountId;
  String accountKey;
  int balance;
  AccountType accountType;

  BankAccount({this.accountId, this.accountKey, this.balance, this.accountType});
  factory BankAccount.fromJson(Map<String, dynamic> json) => new BankAccount(
    accountId: json['id'],
    accountKey: json['encodedKey'],
    balance: int.parse(json['balance']),
    accountType: AccountType.values.firstWhere((e) => e.toString() == 'AccountType.' + json['name'])
  );

  Future<int> getBalance() async {
    try {
      int balance = await BankService.getBalance(this.accountId);
      this.balance = balance;
      return balance;
    } on MambuException catch (e) {
      _processMambuException(e);
    }
  }

  Future<int> deposit(int amt) async {
    try {
      int balance = await BankService.deposit(this.accountId, amt);
      return balance;
    } on MambuException catch (e) {
      _processMambuException(e);
    }
  }

  Future<int> transfer(String to, int amt) async {
    try {
      int balance = await BankService.transfer(this.accountId, to, amt);
      return balance;
    } on MambuException catch (e) {
      _processMambuException(e);
    }
  }

  void _processMambuException(MambuException e) {
    if (e.returnCode == 400) {
      print("Account Doesn't exist.");
    } else {
      print("Unknown Mambu Error has occurred during getBalance. Return Code: " + e.returnCode.toString());
    }
  }
}