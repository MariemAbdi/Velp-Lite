class Validators {
  static String? defaultValidation(dynamic value) {
    if (value == null) return 'This field is required';
    if ((value is String || value is List) && value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  static String? emailValidation(String? email) {
    if (email == null || email.isEmpty) {
      return "This field can't be empty";
    } else if (!RegExp(r'^[a-zA-Z\d.]+@[a-zA-Z\d]+\.[a-zA-Z]+')
        .hasMatch(email)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? passwordValidation(String? password) {
    if (password!.isEmpty) {
      return "This field can't be empty";
    } else if (password.length < 6) {
      return "Password should contain at least 6 characters";
    }
    return null;
  }

  static String? weightValidation(String? weight) {
    if (weight!.isEmpty) {
      return "This field can't be empty";
    } else if (double.tryParse(weight) == null) {
      return 'Only numbers are allowed';
    } else if (double.parse(weight) <= 0 || double.parse(weight) > 150) {
      return 'Weight should be between 0-150kg';
    }
    return null;
  }

  static String? chipValidation(String? number) {
    if (number == null || number.isEmpty) {
      return null; // Allow empty input without validation
    }
    if (int.tryParse(number) == null) {
      return 'Only numbers are allowed';
    } else if (number.length != 10) {
      return 'Chip number has to contain 10 digits';
    }
    return null; // No error
  }
}
