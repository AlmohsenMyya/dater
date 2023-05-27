
class FieldValidator {

  String? validateMobileNumber(String value) {
    if (value.isEmpty) {
      return 'Mobile number is required.';
    } else if (value.length < 8) {
      return 'Enter at least 8 digit mobile number.';
    } else if (value == "00000000") {
      return 'Please enter valid mobile number.';
    }
    return null;
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Phone number is required.';
    } else if (value.length < 8) {
      return 'Enter at least 8 digit phone number.';
    } else if (value == "00000000") {
      return 'Please enter valid phone number.';
    }
    return null;
  }

  String? validateName(String value) {
    if(value.isEmpty) {
      return "Please enter your name.";
    }
    return null;
  }

  String? validateWorkTitle(String value) {
    if(value.isEmpty) {
      return "Please enter work title.";
    }
    return null;
  }

  String? validateHomeTown(String value) {
    if(value.isEmpty) {
      return "Please enter hometown.";
    }
    return null;
  }

  String? validateWorkCompany(String value) {
    if(value.isEmpty) {
      return "Please enter company name.";
    }
    return null;
  }

  String? validateEmail(String value) {
    String emailRegExp = r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    if (value.isEmpty) {
      return "Please enter email address.";
    } else if (!isNumeric(value) &&
        !RegExp(emailRegExp).hasMatch(value)) {
      return "Invalid email address.";
    } else {
      return null;
    }
  }

  bool isNumeric(String s) {
    if (s.isEmpty) {
      return false;
    }
    return double.tryParse(s) != null;
  }

}