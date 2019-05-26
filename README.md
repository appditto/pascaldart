**This is BETA software, use at your own risk**

A PascalCoin library written in Dart, ported based on the [sbx](https://github.com/Techworker/sbx) JavaScript library for PascalCoin.

## Features

* 'pascaldart/common.dart' - Basic models for PascalCoin objects such as PrivateKey, PublicKey, AccountName, AccountNumber, etc. Also several "Coder" objects which encode and decode these objects to byte arrays.
* 'pascaldart/crypto.dart' - PascalCoin cryptography. Generate keys, sign messages, encrypt/decrypt private keys (`PrivateKeyCrypt`), and encrypt/decrypt payloads (`EciesCrypt`)
* 'pascaldart/signing.dart' - PascalCoin signing. Includes operation models (such as `TransactionOperation`), encodes and decodes operations to raw format, and can sign operations using a `PrivateKey`
* 'pascaldart/json_rpc.dart' - An implementation of PascalCoin's [json-rpc API](https://www.pascalcoin.org/development/rpc).

If you want to import everything, import `pascaldart/pascaldart.dart`

## TODO

* Provide examples
* Support multi-operation
* Add parser for walletkeys.dat (from desktop wallet)
* Support Extended PASA (EPASA)
* Much more

## Issues and contributing

Contributions are welcome and encouraged. Simply fork this repository, make changes, and create a pull request.

For issues, create an issue on GitHub

