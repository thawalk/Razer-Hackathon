import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:save_spender/enums/account_type.dart';
import 'package:save_spender/exceptions/mambu_exception.dart';
import 'package:save_spender/models/bank_account_model.dart';

class BankService {
  static final String urlApi = 'https://razerhackathon.sandbox.mambu.com/api/';
  static final basicAuth = 'Basic ' + base64Encode(utf8.encode('Team63:pass11483ACA2C'));
  static final headers = {HttpHeaders.authorizationHeader: basicAuth,
  HttpHeaders.contentTypeHeader: 'application/json'};
  static final productKey = '8a8e878471bf59cf0171bf6979700440';

  // Gets the balance of an account
  // @params accountId is the id of the account (not the encodedKey)
  static Future<int> getBalance(String accountId) async {
    final Response res = await get(urlApi + "savings/$accountId",
      headers: headers,
    );
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      int balance = int.parse(body['balance']);
      return balance;
    } else {
      dynamic body = jsonDecode(res.body);
      int returnCode = int.parse(body['returnCode']);
      String returnStatus = body['returnStatus'];
      throw new MambuException(returnCode, returnStatus);
    }
  }

  // Deposits amt into an account
  // @params accountId is the id of the account (not the encodedKey)
  static Future<int> deposit(String accountId, int amt) async {
    // Generate idempotency key via uuid
    final url = urlApi + "savings/$accountId/transactions";
    var body = {
      'amount': amt,
      'notes': 'testing',
      'type': 'DEPOSIT',
      'method': 'bank',
      'customInformation': [
        {
          'value': 'unique identifier for receipt',
          'customFieldID': 'IDENTIFIER_TRANSACTION_CHANNEL_I'
        }
      ]
    };
    final Response res = await post(url,
        headers: headers,
        body: jsonEncode(body));

    if (res.statusCode == 201) {
      dynamic body = jsonDecode(res.body);
      int balance = int.parse(body['balance']);
      return balance;
    } else {
      dynamic body = jsonDecode(res.body);
      int returnCode = int.parse(body['returnCode']);
      String returnStatus = body['returnStatus'];
      throw new MambuException(returnCode, returnStatus);
    }
  }

  // Transfers amt from srcAccountId to destAccountId
  static Future<int> transfer(String srcAccountId, String destAccountId, int amt,
      {String msg = "Transfer via SaveSpender"}) async {
    var url = urlApi + "savings/$srcAccountId/transactions";
    var body = {
      "type": "TRANSFER",
      "amount": amt,
      "notes": msg,
      "toSavingsAccount": destAccountId,
      "method":"bank"
    };
    final Response res = await post(url, headers: headers, body: jsonEncode(body));
    if (res.statusCode == 201) {
      dynamic body = jsonDecode(res.body);
      int balance = int.parse(body['balance']);
      return balance;
    } else {
      dynamic body = jsonDecode(res.body);
      int returnCode = int.parse(body['returnCode']);
      String returnStatus = body['returnStatus'];
      throw new MambuException(returnCode, returnStatus);
    }
  }

  // Creates a new account
  // ClientId refers to the Mambu encodedKey of the client
  // Returns a map of the id and encodedKey of the created account
  static Future<BankAccount> createAccount(String clientId, AccountType accountType) async {
    var name;
    switch (accountType) {
      case AccountType.WALLET:
        name = 'WALLET';
        break;
      case AccountType.SAVINGS:
        name = 'SAVINGS';
        break;
      default:
        name = 'WALLET';
    }
    final url = urlApi + "savings";
    var body = {
      "savingsAccount": {
        "accountHolderKey": clientId,
        "accountHolderType": "CLIENT",
        "name": name,
        "productTypeKey": "8a8e878471bf59cf0171bf6979700440",
        "notes": "Created from App",
        "accountState": "APPROVED",
        "accountType": "CURRENT_ACCOUNT",
        "allowOverdraft": "true",
        "overdraftLimit": "0",
        "overdraftInterestSettings": {
          "interestRate": 0
        },
        "interestSettings": {
          "interestRate": 0
        }
      }
    };
    final Response res = await post(url, headers: headers, body: jsonEncode(body));
    if (res.statusCode == 201) {
      dynamic body = jsonDecode(res.body)['savingsAccount'];
      return BankAccount.fromJson(body);
    } else {
      dynamic body = jsonDecode(res.body);
      int returnCode = int.parse(body['returnCode']);
      String returnStatus = body['returnStatus'];
      throw new MambuException(returnCode, returnStatus);
    }
  }

  // Deletes an account
  // @params accountId may be either id or encodedKey of an account
  static Future<bool> deleteAccount(String accountId) async {
    var url = urlApi + "savings/$accountId";
    final Response res = await delete(url,headers: headers);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}