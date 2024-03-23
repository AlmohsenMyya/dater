class ApiUrl {
  static const apiMainPath = "https://oudeen.com/dater/";

  //authantication api's
  static const loginByEmailApi = "${apiMainPath}api/email_login";
  static const loginApi = "${apiMainPath}api/login";
  static const accountActiveApi = "${apiMainPath}api/activate";
  static const accountActiveByEmailApi = "${apiMainPath}api/activate_email";
  static const completeSignUpApi = "${apiMainPath}api/complete_signup";
  static const resendCodeApi = "${apiMainPath}api/resend_code";
  static const resendCodeByEmailApi = "${apiMainPath}api/resend_code_email";

  static const setFCMToken = "${apiMainPath}api/set_client_token";

  static const getGenderApi = "${apiMainPath}api/get_genders";
  static const getGoalApi = "${apiMainPath}api/get_goals";

  // static const getSexualityApi = "${apiMainPath}api/get_sexuality";
  // static const getTargetGenderApi = "${apiMainPath}api/get_target_gender";

  static const getInterestsApi = "${apiMainPath}api/get_interests";
  static const saveInterestsApi = "${apiMainPath}api/set_interest";
  static const uploadPhotoApi = "${apiMainPath}api/upload_photo";

  // Country Code List API
  static const getCountryCodeApi = "http://country.io/phone.json";

  //home screen api's
  static const likeProfileApi = "${apiMainPath}api/like";
  static const superLoveProfileApi = "${apiMainPath}api/like";

  static const matchesApi = "${apiMainPath}api/matches";
  static const getLikerApi = "${apiMainPath}api/likers";
  static const unBlurImgApi = "${apiMainPath}api/unblur_liker_image";

  static const getUserDetailsApi = "${apiMainPath}api/get_user_full_details";
  static const getReferralCodeApi = "${apiMainPath}api/get_referral_number";
  static const getCoinsApi = "${apiMainPath}api/get_my_coins";
  static const updateStepsApi = "${apiMainPath}api/submit_steps";
  static const saveBirthYearApi = "${apiMainPath}api/add_birth_year";
  static const deleteUserAccountApi = "${apiMainPath}api/delete_account";
  static const updateUserLocationApi = "${apiMainPath}api/update_location";
  static const getUserAgeApi = "${apiMainPath}api/get_birth_year";
  static const sendMessageApi = "${apiMainPath}api/messages/send";
  static const unMatchApi = "${apiMainPath}api/unmatch";
  static const getChatListApi = "${apiMainPath}api/messages/open";
  static const getSuggestionApi = "${apiMainPath}api/suggestions";
  static const getLoggedInUserProfileApi =
      "${apiMainPath}api/get_logged_full_details";
  static const setUserLanguageApi = "${apiMainPath}api/set_language";
  static const deleteUserPhotoApi = "${apiMainPath}api/delete_photo";
  static const getLanguageApi = "${apiMainPath}api/get_languages";
  static const getPoliticsApi = "${apiMainPath}api/get_politics";
  static const getReligionApi = "${apiMainPath}api/get_religion";
  static const getStarSignApi = "${apiMainPath}api/get_starsign";
  static const setStarSignApi = "${apiMainPath}api/set_star_sign";
  static const getPromptsApi = "${apiMainPath}api/get_prompts";
  static const setPromptsApi = "${apiMainPath}api/set_prompt";
  static const getPrivacyPolicyApi = "${apiMainPath}api/get_privacy_policy";
  static const getTermsAndConditionApi = "${apiMainPath}api/get_terms_of_use";
  static const getCommunityGuidelineApi =
      "${apiMainPath}api/get_community_guidelines";
  static const setVerifiedApi = "${apiMainPath}api/set_as_verified";
  static const uploadVerificationPhotoApi =
      "${apiMainPath}api/upload_verification_photo";
  static const changePhoneNumberApi = "${apiMainPath}api/change_phone_number";
  static const setCoverImageApi = "${apiMainPath}api/set_cover_photo";
  static const getCountriesApi = "${apiMainPath}api/get_contries";

  static const getReportsTypesApi = "${apiMainPath}api/get_report_options";
  static const reportUser = "${apiMainPath}api/report_account";
}
