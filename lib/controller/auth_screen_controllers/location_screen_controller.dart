import 'dart:convert';
import 'dart:developer';
import 'package:dater/constants/api_url.dart';
import 'package:dater/constants/messages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import '../../model/authentication_model/complete signup_screen_model/complete signup_model.dart';
import '../../model/location_screen_model/location_model.dart';
import '../../utils/preferences/user_preference.dart';


class LocationScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  RxInt successStatus = 0.obs;

  Location location = Location();
  late LocationData locationData;

  var dioRequest = dio.Dio();

  List<CountryData> countryList = [];
  List<CountryData> searchCountryList = [];

  CountryData selectedCountryData = CountryData();
  UserPreference userPreference = UserPreference();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController searchTextFieldController = TextEditingController();
  // TextEditingController locationFieldController = TextEditingController();

  /// Save Location Function
  Future<void> saveUserLocationFunction() async {
    isLoading(true);
    String url = ApiUrl.updateUserLocationApi;
    log('Update User location Api Url : $url');

    try {

    } catch(e) {
      log('saveUserLocationFunction Error :$e');
      rethrow;
    }

    isLoading(false);

  }


  Future<void> getCountriesFunction() async {
    isLoading(true);
    String url = ApiUrl.getCountriesApi;
    log('Get Countries Api Url : $url');

    try {
      var response = await dioRequest.get(url);
      log('getCountries Response : ${response.data}');
      CountryModel countryModel = CountryModel.fromJson(json.decode(response.data));

      successStatus.value = countryModel.statusCode;

      if(successStatus.value == 200) {
        countryList.clear();
        countryList.addAll(countryModel.msg);
        searchCountryList = countryList;
        log('countryList Length : ${countryList.length}');
      } else {
       log('getCountriesFunction Else');
      }

    } catch(e) {
      log('getCountriesFunction Error :$e');
      rethrow;
    }

    isLoading(false);

  }

  Future<void> updateUserLocationFunction(
      {required String key, required String value}) async {
    isLoading(true);
    String url = ApiUrl.completeSignUpApi;
    log('Update User Profile Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;
      request.fields[key] = value;

      log('Request Field : ${request.fields}');
      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value1) async {
        log('value : $value1');
        CompleteSignupModel completeSignupModel =
        CompleteSignupModel.fromJson(json.decode(value1));
        successStatus.value = completeSignupModel.statusCode;

        if (successStatus.value == 200) {
          log('Update User Profile Success : $key & $value');
          Fluttertoast.showToast(msg: completeSignupModel.msg);
          Get.back();
        } else {
          log('updateUserProfileFunction Else');
        }
      });
    } catch (e) {
      log('updateUserProfileFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  void searchCountryFunction(String countryName) {
    List<CountryData> tempCountryList = [];

    for(var value in countryList) {
      if(value.name!.toLowerCase().contains(countryName.toLowerCase())) {
        tempCountryList.add(value);
      }
    }

    searchCountryList = tempCountryList;
    loadUI();
  }

  void countryValueSelectFromListFunction(countryId) {
    for(var value in countryList) {
      value.isSelected = false;
      if(value.id == countryId) {
        value.isSelected = true;
        selectedCountryData = value;
        log('selectedCountryData id : ${selectedCountryData.id}');
        log('selectedCountryData name : ${selectedCountryData.name}');
      }
    }
    log('countryId :$countryId');
    loadUI();
  }


  Future<void> confirmButtonFunction() async {
    if(selectedCountryData.id == "") {
      Fluttertoast.showToast(msg: "Please select country");
    } else {
      await updateUserLocationFunction(
        key: AppMessages.countryApiText,
        value: selectedCountryData.id!,
      );
    }
  }


  @override
  void onInit() {
    initMethod();
    super.onInit();
  }


  Future<void> initMethod() async {
    isLoading(true);
    locationData = await location.getLocation();
    log('locationData latitude : ${locationData.latitude}');
    log('locationData longitude : ${locationData.longitude}');
    await getCountriesFunction();
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }


}
