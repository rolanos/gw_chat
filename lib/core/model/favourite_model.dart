// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ClassType {
  country("Country"),
  city("City");

  const ClassType(this.name);

  final String name;

  static ClassType? fromString(String? classType) {
    if (classType == null) {
      return null;
    }
    switch (classType) {
      case "Country":
        return ClassType.country;
      case "City":
        return ClassType.city;
    }
  }
}

@immutable
class FavouriteModel extends Equatable {
  final int id;
  final String? name;
  final String? wikiUrl;
  final String? flagUrl;
  final ClassType? classType;

  const FavouriteModel({
    required this.id,
    required this.name,
    required this.wikiUrl,
    required this.flagUrl,
    required this.classType,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      wikiUrl,
      flagUrl,
      classType,
    ];
  }

  FavouriteModel copyWith({
    int? id,
    String? name,
    String? wikiUrl,
    String? flagUrl,
    ClassType? classType,
  }) {
    return FavouriteModel(
      id: id ?? this.id,
      name: name ?? this.name,
      wikiUrl: wikiUrl ?? this.wikiUrl,
      flagUrl: flagUrl ?? this.flagUrl,
      classType: classType ?? this.classType,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'wikiUrl': wikiUrl,
      'flagUrl': flagUrl,
      'classType': classType?.name,
    };
  }

  factory FavouriteModel.fromJson(Map<String, dynamic> map) {
    return FavouriteModel(
      id: map['id'] as int,
      name: map['name'] != null ? map['name'] as String : null,
      wikiUrl: map['wikiUrl'] != null ? map['wikiUrl'] as String : null,
      flagUrl: map['flagUrl'] != null ? map['flagUrl'] as String : null,
      classType: map['classType'] != null
          ? ClassType.fromString(map['classType'] as String?)
          : null,
    );
  }
  @override
  bool get stringify => true;
}
