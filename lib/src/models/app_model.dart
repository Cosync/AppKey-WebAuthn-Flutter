 
//
//  app_model.dart
//  AppKey WebAuthn Flutter
//
//  Licensed to the Apache Software Foundation (ASF) under one
//  or more contributor license agreements.  See the NOTICE file
//  distributed with this work for additional information
//  regarding copyright ownership.  The ASF licenses this file
//  to you under the Apache License, Version 2.0 (the
//  "License"); you may not use this file except in compliance
//  with the License.  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.
//
//  Created by Tola Voeung.
//  Copyright © 2025 cosync. All rights reserved.
//


class AppModel {
  final String appId;
  final String displayAppId;
  final String name;
  final String userId;
  final String status; 
  final String handleType;  
  final String appToken;
  final String signup;
  final bool anonymousLoginEnabled;
  final bool userNamesEnabled; 
  final bool appleLoginEnabled;
  final String? appleBundleId;
  final bool googleLoginEnabled;
  final String? googleClientId;
  final String relyPartyId;
  final String? androidApkKey;
  final  List <String> locales;
 


  AppModel( {
    required this.appId,
    required this.displayAppId,
    required this.name,
    required this.userId,
    required this.status,
    required this.handleType,
    required this.appToken,
    required this.signup,
    required this.anonymousLoginEnabled, 
    required this.userNamesEnabled,
    required this.appleLoginEnabled,
    this.appleBundleId,
    required this.googleLoginEnabled,
    this.googleClientId,
    required this.relyPartyId,
    this.androidApkKey,
    required this.locales,
  }
  );

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
          appId: json['appId'],
          displayAppId: json['displayAppId'],
          name: json['name'],
          userId: json['userId'],
          status: json['status'],
          handleType: json['handleType'],
          appToken: json['appToken'],
          signup: json['signup'],
          anonymousLoginEnabled: json['anonymousLoginEnabled'],
          userNamesEnabled: json['userNamesEnabled'],
          appleLoginEnabled:json['appleLoginEnabled'],
          appleBundleId:json['appleBundleId'],
          googleLoginEnabled: json['googleLoginEnabled'],
          googleClientId: json['googleClientId'],
          relyPartyId: json['relyPartyId'],
          androidApkKey: json['androidApkKey'],

          locales: json['locales'] != null
          ? (json['locales'] as List)
              .map((item) => item.toString() )
              .toList()
          : [],

 
    );
  }

}
 