String? emailValidator(String? value) {
  // Regular expression for email validation
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  if (value == null || value.isEmpty) {
    return 'Please enter an email address';
  } else if (value.trim().length >= 100) {
    return 'Email address is too long';
  } else if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  } else {
    return null; // The email is valid
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  } else if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  } else if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Password must contain at least one number';
  } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return 'Password must contain at least one special character';
  } else {
    return null; // The password is valid
  }
}
