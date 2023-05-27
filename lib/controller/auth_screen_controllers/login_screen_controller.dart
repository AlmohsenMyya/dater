import 'dart:developer';

import 'package:get/get.dart';
import 'package:location/location.dart';

import '../../utils/preferences/signup_preference.dart';

class LoginInScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isUserFirstTime = true.obs;
  SignUpPreference signUpPreference = SignUpPreference();

  Future<void> getUserFirstTimeOrNot() async {
    isLoading(true);

    // If user already signup then show only signIn Button
    isUserFirstTime.value = await signUpPreference.getBoolFromPrefs(
        key: SignUpPreference.isUserFirstTimeKey);
    // isUserFirstTime.value = false;
    await fetchLocation();
    isLoading(false);
  }

  fetchLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    LocationData _currentPosition;

    String _address;
    PermissionStatus _permissionGranted;

    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   log("111");
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    //   _currentPosition = await location.getLocation();
    //   location.onLocationChanged.listen((LocationData currentLocation) {
    //     setState(() {
    //       _currentPosition = currentLocation;
    //       getAddress(_currentPosition.latitude, _currentPosition.longitude)
    //           .then((value) {
    //         setState(() {
    //           _address = "＄{value.first.addressLine}";
    //         },);
    //       });
    //     });
    //   });
    // }
  }
  //  Future<bool> handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     Get.to(() => LocationPermissionScreen());
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
  //       content: Text(
  //         'Location services are disabled. Please enable the services',
  //       ),
  //     ),
  //     );
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(Get.context!).showSnackBar(
  //         const SnackBar(
  //           content: Text('Location permissions are denied'),
  //         ),
  //       );
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(
  //       const SnackBar(
  //         content: Text(
  //             'Location permissions are permanently denied, we cannot request permissions.'),
  //       ),
  //     );
  //     return false;
  //   }

  //   return true;
  // }

  @override
  void onInit() {
    getUserFirstTimeOrNot();
    super.onInit();
  }
}
