String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }

    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return "Invalid email address";
    }
    return null;
  }

String? validatePassword(String? value) {
  final regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (value == null || value.isEmpty) {
    return "Please enter your password";
  }

  if(!regex.hasMatch(value)) {
    return "The password doesn't enforce the policy: \n" +
          "at least 8 characters\n" +
          "at least 1 digit\n" +
          "at least 1 capital character\n"+
          "at least 1 special character\n";
  }

  return null;
}

String? confirmPassword(String? password, String? value) {
  if (value == null || value.isEmpty || password == null || password.isEmpty) {
    return "Please enter your password";
  }

  if (password != value) {
    return "password mismatch";
  }
  return null;

}