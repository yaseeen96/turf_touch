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

String? mobileNumberValidator(String? value) {
  // Regular expression for validating an Indian mobile number
  final RegExp mobileRegex = RegExp(r'^[6789]\d{9}$');

  if (value == null || value.isEmpty) {
    return 'Please enter a mobile number';
  } else if (!mobileRegex.hasMatch(value)) {
    return 'Please enter a valid 10-digit Indian mobile number';
  }
  return null; // The mobile number is valid
}

String? nameValidator(String? value) {
  // Regular expression for validating a name (allowing alphabetic characters and spaces only)
  final RegExp nameRegex = RegExp(r'^[a-zA-Z\s]+$');

  if (value == null || value.isEmpty) {
    return 'Please enter a name'; // Check if the value is null or empty
  } else if (!nameRegex.hasMatch(value)) {
    return 'Please enter a valid name (alphabetic characters only)'; // Check if the name matches the pattern
  }
  return null; // The name is valid
}
