


//
//  appkey_webauthn.dart
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



import 'package:appkey_webauthn_flutter/src/models/app_model.dart';
import 'package:appkey_webauthn_flutter/src/models/user_model.dart';
import 'package:appkey_webauthn_flutter/src/utils.dart';
import 'package:credential_manager/credential_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AppkeyWebAuthn {
   

  String appToken;
  String? apiUrl;
  UserModel? user;
  
  AppkeyWebAuthn(this.appToken, this.apiUrl);


  _apiRequest(String method, String endpoint, [dynamic data, String? accessToken, String? signupToken] )  async {
    apiUrl = apiUrl != "" ? apiUrl : "https://api.appkey.io";

    var headers = {'Content-Type': 'application/json'};

    if (accessToken != "" && accessToken != null) {
      headers['access-token'] = accessToken;
    } else if (signupToken != "" && signupToken != null) {
      headers['signup-token'] = signupToken;
    } else {
      headers['app-token'] = appToken;
    }

    if (method == "GET") {
      final response = await http.get(
        Uri.parse("$apiUrl/$endpoint"),
        headers: headers,
      );
       
      Utils.chekcFailureFromResponse(response);

      return response;
    }

    final params = data ?? {};
    final response = await http.post(
      Uri.parse("$apiUrl/$endpoint"),
      body: jsonEncode(params),
      headers: headers,
    );

    Utils.chekcFailureFromResponse(response);

    return response;
  }

  Future<AppModel> getApp() async {
    final response = await _apiRequest("GET", "api/appuser/app");
    final decode = jsonDecode(response.body);
    return AppModel.fromJson(decode);
  }

  Future<CredentialCreationOptions> signup(
      String handle, String displayName, [String? locale]) async {
    final response = await _apiRequest("POST", "api/appuser/signup",
        {'handle': handle, 'displayName': displayName, "locale": locale});
    final decode = jsonDecode(response.body);

    decode['challenge'] = Utils.base64UrlToBase64(decode['challenge']);
    return CredentialCreationOptions.fromJson(decode);
  }

  Future< Map<String, dynamic>> signupConfirm(
      String handle, PublicKeyCredential request) async {
    Map<String, dynamic> params = {
      'handle': handle,
    };

    params.addAll(request.toJson());
    final response = await _apiRequest(
        "POST", "api/appuser/signupConfirm", params);
    final decode = jsonDecode(response.body);
    return decode;
  }

  Future<UserModel> signupComplete(String code, String signupToken) async { 
    final response = await _apiRequest("POST", "api/appuser/signupComplete",
        {"code": code}, null, signupToken);
    final decode = jsonDecode(response.body);
    user = UserModel.fromJson(decode);
    return user!; 
  }

  // Initialize passkey login
  Future<Map<String, dynamic>> login(String handle) async {
    final response = await _apiRequest(
        "POST", "api/appuser/login", {'handle': handle});
    final decode = jsonDecode(response.body);

    decode['challenge'] = Utils.base64UrlToBase64(decode['challenge']);

    return decode;
  }

  // Initialize passkey loginComplete
  Future<UserModel> loginComplete(
      String handle, PublicKeyCredential request) async {
    Map<String, dynamic> body = {
      'handle': handle,
    };
    body.addAll(request.toJson());

    final response = await _apiRequest(
        "POST", "api/appuser/loginComplete", body);

    final decode = jsonDecode(response.body);
    user = UserModel.fromJson(decode);
    return user!;
  }

  Future<CredentialCreationOptions> loginAnonymous(handle) async {
    final response = await _apiRequest(
        "POST", "api/appuser/loginAnonymous", {'handle': handle});
    final decode = jsonDecode(response.body);
    decode['challenge'] = Utils.base64UrlToBase64(decode['challenge']);
    return CredentialCreationOptions.fromJson(decode);
  }

  Future<UserModel> loginAnonymousComplete(
      String handle, PublicKeyCredential request) async {
    Map<String, dynamic> body = {
      'handle': handle,
    };

    body.addAll(request.toJson());

    final response = await _apiRequest(
        "POST", "api/appuser/loginAnonymousComplete", body);
    final decode = jsonDecode(response.body);

    user = UserModel.fromJson(decode);
    return user!;
  }

  Future<bool> setUserName(String userName, String accessToken) async {
    final response = await _apiRequest("POST", "api/appuser/setUserName",
        {"userName": userName}, accessToken);
    final decode = jsonDecode(response.body);
    return decode;
  }

  Future<bool> updateProfile(String displayName, String accessToken) async {
    final response = await _apiRequest("POST", "api/appuser/updateProfile",
        {"displayName": displayName}, accessToken);

    final decode = jsonDecode(response.body);

    return decode;
  }

  Future<UserModel> setLocale(String locale, String accessToken) async {
    final response = await _apiRequest(
        "POST", "api/appuser/setLocale", {"locale": locale}, accessToken);
    final decode = jsonDecode(response.body);
    user = UserModel.fromJson(decode);
    return user!;
  }

  Future<Map<String, dynamic>> userNameAvailable(
      String userName, String accessToken) async {
    final response = await _apiRequest(
        "GET",
        "api/appuser/userNameAvailable?userName=$userName",
        null,
        accessToken,
        null);
    return jsonDecode(response.body);
  }

  Future<UserModel> socialLogin(Map<String, dynamic> data) async {
    final response =
        await _apiRequest("POST", "api/appuser/socialLogin", data);
    final decode = jsonDecode(response.body);
    user = UserModel.fromJson(decode);
    return user!;
  }

  Future<UserModel> socialSignup(Map<String, dynamic> data) async {
    final response =
        await _apiRequest("POST", "api/appuser/socialSignup", data);
    final decode = jsonDecode(response.body);
    user = UserModel.fromJson(decode);
    return user!;
  }

  Future<UserModel> verifySocialAccount(
      Map<String, dynamic> data) async {
    final response = await _apiRequest(
        "POST", "api/appuser/verifySocialAccount", data);
    final decode = jsonDecode(response.body); 
    user = UserModel.fromJson(decode);
    return user!;
  }

  // Initialize passkey login
  Future<CredentialLoginOptions> verify(String handle) async {
    final response = await _apiRequest(
        "POST", "api/appuser/verify", {'handle': handle});
    final decode = jsonDecode(response.body);

    decode['challenge'] = Utils.base64UrlToBase64(decode['challenge']);
    final result = CredentialLoginOptions.fromJson(decode);
    return result;
  }

  Future<UserModel> verifyComplete(
      String handle, PublicKeyCredential request) async {
    Map<String, dynamic> body = {
      'handle': handle,
    };
    body.addAll(request.toJson());
    final response = await _apiRequest(
        "POST", "api/appuser/verifyComplete", body);
    final decode = jsonDecode(response.body);
    user = UserModel.fromJson(decode);
    return user!;
  }

  Future<UserModel> updatePasskey(
      String id, String keyName, String accessToken) async {
    final response = await _apiRequest("POST", "api/appuser/updatePasskey",
        {"keyId": id, "keyName": keyName}, accessToken);

    final decode = jsonDecode(response.body);
    user = UserModel.fromJson(decode);
    return user!;
  }

  Future<CredentialCreationOptions> addPasskey(String token) async {
    final response =
        await _apiRequest("POST", "api/appuser/addPasskey", {}, token);
    final decode = jsonDecode(response.body);

    decode['challenge'] = Utils.base64UrlToBase64(decode['challenge']);
    return CredentialCreationOptions.fromJson(decode);
  }

  Future<UserModel> addPasskeyComplete(
      String handle, PublicKeyCredential request, String token) async {
    Map<String, dynamic> body = {
      'handle': handle,
    };

    body.addAll(request.toJson());
    final response = await _apiRequest(
        "POST", "api/appuser/addPasskeyComplete", body, token);
    final decode = jsonDecode(response.body);
    user = UserModel.fromJson(decode);
    return user!;
  }

  Future<UserModel> removePasskey(String keyId, String token) async {
    final response = await _apiRequest(
        "POST", "api/appuser/removePasskey", {"keyId": keyId}, token);
    final decode = jsonDecode(response.body);
    user = UserModel.fromJson(decode);
    return user!;
  }
}
