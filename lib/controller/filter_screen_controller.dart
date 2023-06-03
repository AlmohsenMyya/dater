import 'package:get/get.dart';

class FilterScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool onSelectedAge = false.obs;
  RxBool onSelectedDistance = false.obs;
  RxBool onSelectedExercise= false.obs;
  RxBool onSelectedRatherDate= false.obs;


  RxDouble startValAge = 18.0.obs;
  RxDouble endValAge = 100.0.obs;



RxDouble startValDistance = 1.0.obs;
  RxDouble endValDistance = 300.0.obs;



  RxDouble startValExercise = 18.0.obs;
  RxDouble endValExercise= 60.0.obs;


  
  RxDouble startValRatherDate = 18.0.obs;
  RxDouble endValRatherDate= 60.0.obs;


  // void toggle() => onSelected.value = onSelected.value ? false : true;
}
