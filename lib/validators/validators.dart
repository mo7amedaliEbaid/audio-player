class Validators {
  static String? required(value) {
    if (value == null || value.isEmpty) {
      return "Field required!";
    }
    return null;
  }

  static String? emailValidator(emailAddress) {
    if (emailAddress == null) return 'Email cannot be empty!';

    bool emailValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(emailAddress);

    if (emailAddress == "") {
      return "Email cannot be empty!";
    } else if (!emailValid) {
      return "Invalid Email address!";
    }
    return null;
  }

  static String? passwordValidator(password) {
    if (password == null) return "Password cannot be empty!";
    // bool passValid =
    //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
    //         .hasMatch(password);
    if (password.isEmpty) {
      return "Password cannot be empty!";
    }
    //  else if (!passValid) {
    //   return "Requirements missing!";
    // }
    else if (password.length < 6) {
      return "Password must be greater than 6 characters!";
    }
    return null;
  }

  static String? dobValidator(DateTime? value) {
    if (value == null) {
      return "DOB cannot be empty!";
    }
    if (value.isAfter(DateTime.now())) {
      return "DOB cannot be in the future!";
    }
    return null;
  }
}
