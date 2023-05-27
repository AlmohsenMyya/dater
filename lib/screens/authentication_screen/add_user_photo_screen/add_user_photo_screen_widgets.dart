import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_screen_controllers/add_user_photo_screen_controller.dart';


class UserImageSelectModule extends StatelessWidget {
  UserImageSelectModule({Key? key}) : super(key: key);
  final screenController = Get.find<AddUserPhotoScreenController>();
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () async { await screenController.pickImageFromGallery(index);},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor,
            ),
            child: index == 0
                ? _firstItem()
                : index == 1
                ? _secondItem()
                : _thirdItem(),
          ),
        );
      },
    ).commonSymmetricPadding(horizontal: 20, vertical: 20);
  }

  Widget _firstItem() {
    return Container(
      child: screenController.image1.path.isEmpty
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightOrangeColor,
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: AppColors.whiteColor,
                    size: 16,
                  ),
                ),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(screenController.image1, fit: BoxFit.cover),
            ),
    );
  }

  Widget _secondItem() {
    return Container(
      child: screenController.image2.path.isEmpty
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightOrangeColor,
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: AppColors.whiteColor,
                    size: 16,
                  ),
                ),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(screenController.image2, fit: BoxFit.cover),
            ),
    );
  }

  Widget _thirdItem() {
    return Container(
      child: screenController.image3.path.isEmpty
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightOrangeColor,
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: AppColors.whiteColor,
                    size: 16,
                  ),
                ),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(screenController.image3, fit: BoxFit.cover),
            ),
    );
  }
}



class PointHintModule extends StatelessWidget {
  const PointHintModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 15,
          child: Container(),
        ),
        Expanded(
          flex: 85,
          child: Column(
            children: [
              _singleItemModule(
                number: '1- ',
                text: 'Try to be spontaneous',
              ),
              _singleItemModule(
                number: '2- ',
                text: 'Try to be alone',
              ),
              _singleItemModule(
                number: '3- ',
                text: 'Smile to be swiped',
              ),
              _singleItemModule(
                number: '4- ',
                text: 'Stay away from blurry photos',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _singleItemModule({required String number, required String text}) {
    return Row(
      children: [
        Text(number,
          style: TextStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              fontSize: 15
          ),),
        Expanded(
          child: Text(text,
            style: TextStyle(
                fontFamily: FontFamilyText.sFProDisplayRegular,
                fontSize: 15
            ),),
        ),
      ],
    ).commonSymmetricPadding(vertical: 4);
  }
}
