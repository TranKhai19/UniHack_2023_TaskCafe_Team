class Validator {
  static String? validateName({String? name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return 'Tên không được để trống';
    }

    return null;
  }

  static String? validateEmail({String? email}) {
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email không được để trống';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Vui lòng nhập đúng email của bạn!';
    }

    return null;
  }

  static String? validatePassword({String? password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Mật khẩu không được để trống!';
    } else if (password.length < 6) {
      return 'Mật khẩu cần ít nhất 6 kí tự!';
    }

    return null;
  }

  static String? validateConfirmPassword(
      {String? password, String? confirmPassword}) {
    if (confirmPassword == null) {
      return null;
    }
    if (confirmPassword.isEmpty) {
      return 'Mật khẩu không được để trống!';
    } else if (confirmPassword.length < 6) {
      return 'Mật khẩu cần ít nhất 6 kí tự!';
    } else if (password != confirmPassword) {
      return 'Mật khẩu xác nhận không giống với mật khẩu bạn đã nhập!';
    }

    return null;
  }
}