 

//
//  user_model.dart
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

 

class UserModel {
  final String handle;
  final String displayName;
  final String status;
  final String appUserId;
  final String appId; 
  final String? userName; 
  final List <Authenticator> authenticators;
  final String locale; 
  final String loginProvider;
  final String? jwt;
  final String accessToken;
  final String? lastLogin;
  final String? createdAt;
  final String? updatedAt;


  UserModel( {
    required this.handle,
    required this.displayName,
    required this.status,
    required this.appUserId,
    required this.appId,
    this.userName,
    required this.authenticators,
    required this.locale,
    required this.loginProvider,
    this.jwt,
    required this.accessToken,
    this.lastLogin,
    this.createdAt,
    this.updatedAt, 
  }
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        handle: json['handle'],
        displayName: json['displayName'],
        status: json['status'],
        appUserId: json['appUserId'],
        appId: json['appId'],
        userName: json['userName'],
      
        authenticators: json['authenticators'] != null
          ? (json['authenticators'] as List)
              .map((item) =>  Authenticator.fromJson(item) )
              .toList()
          : [],

        locale: json['locale'],
        loginProvider: json['loginProvider'],
        jwt: json['jwt'],
        accessToken: json['access-token'] ?? json['accessToken'],
        lastLogin: json['lastLogin'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],  

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'handle': handle,
      'displayName': displayName,
      'status': status,
      'appUserId': appUserId,
      'appId': appId,
      'userName': userName,
      'authenticators' : ( authenticators as List).map((item) => item.toJson()).toList(), 
      'locale' : locale,
      'loginProvider': loginProvider,
      'jwt' : jwt,
      'accessToken' : accessToken,
      'lastLogin' : lastLogin,
      'createdAt' : createdAt,
      'updatedAt' : updatedAt
    };
  }

}

class Authenticator {
  final String id;
  final String publicKey;
  final int counter;
  final String deviceType;
  final bool credentialBackedUp;
  final String name;
  final String? displayName;
  final String type;
  final String transports;
  final String platform;
  final String? lastUsed;
  final String? createdAt;
  final String? updatedAt;

  Authenticator({
    required this.id,
    required this.publicKey,
    required this.counter,
    required this.deviceType,
    required this.credentialBackedUp,
    required this.name,
    this.displayName,
    required this.type,
    required this.transports,
    required this.platform,
    this.lastUsed,
    this.createdAt,
    this.updatedAt
  });

  factory Authenticator.fromJson(Map<String, dynamic> json) {
    return Authenticator(
        id: json['id'],
        publicKey: json['publicKey'],
        counter: json['counter'],
        deviceType: json['deviceType'],
        credentialBackedUp: json['credentialBackedUp'],
        name: json['name'],
        displayName: json['displayName'],
        type: json['type'],
        transports: json['transports'],
        platform: json['platform'], 
        lastUsed: json['lastUsed'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],  

    );
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'publicKey': publicKey,
      'counter': counter,
      'deviceType': deviceType,
      'credentialBackedUp': credentialBackedUp,
      'name': name,
      'displayName' : displayName,
      'type' : type,
      'transports': transports,
      'platform' : platform,
      'lastUsed' : lastUsed, 
      'createdAt' : createdAt,
      'updatedAt' : updatedAt
    };
  }

}
