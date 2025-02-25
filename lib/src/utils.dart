
//
//  utils.dart
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


import 'dart:convert';
 
import 'package:appkey_webauthn_flutter/src/appkey_error.dart';

class Utils {


  static String base64ToBase64Url(String base64) {
    // Replace '+' with '-', '/' with '_'
    String base64Url = base64.replaceAll('+', '-').replaceAll('/', '_');

    // Remove padding characters ('=')
    base64Url = base64Url.replaceAll('=', '');
    return base64Url;
  }

  static String base64UrlToBase64(String base64Url) {
    // Replace '-' with '+' and '_' with '/'
    String base64 = base64Url.replaceAll('-', '+').replaceAll('_', '/');

    // Add padding characters if necessary
    switch (base64.length % 4) {
      case 2:
        base64 += '==';
        break;
      case 3:
        base64 += '=';
        break;
    }

    return base64;
  }


  static chekcFailureFromResponse(dynamic response) {  
    
    if (response.statusCode != 200) {   
      final data = jsonDecode(response.body);  
      throw AppkeyError.fromJson(data);
    }
 
  } 

  static AppkeyError defaultError() {  
    throw AppkeyError.defaultError(); 
  } 


}
