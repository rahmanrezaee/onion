class User {
  int id;
  String name;
  String email;
  String username;
  String phone;
  String password;
  String occupation;
  String interst;
  String country;
  String state;

   Map<String, String> toMap() {
    return {
      'username': '$name',
      'email': '$email',
      'phone': '$phone',
      'password': '$password',
      // 'username': '$username',
      'occupation': '$occupation',
      'interestedin': '$interst',
      'country': '$country',
      'state': '$state',
    };
  }
}
