// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountsResponse _$AccountsResponseFromJson(Map<String, dynamic> json) =>
    AccountsResponse(
      accounts: (json['result'] as List<dynamic>?)
          ?.map((e) => PascalAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountsResponseToJson(AccountsResponse instance) =>
    <String, dynamic>{
      'result': instance.accounts,
    };
