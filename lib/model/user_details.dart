class UserDetails {
  String name;
  String mobileNo;
  String email;
  String address;

  UserDetails({required this.name, required this.mobileNo, required this.email, required this.address});

  factory UserDetails.empty() {
    return UserDetails(name: '', mobileNo: '', email: '', address: '');
  }

  void copyWith({String? name, String? mobileNo, String? email, String? address}) {
    if (name != null) this.name = name;
    if (mobileNo != null) this.mobileNo = mobileNo;
    if (email != null) this.email = email;
    if (address != null) this.address = address;
  }

  bool isValid() {
    return name.isNotEmpty && mobileNo.isNotEmpty && address.isNotEmpty;
  }
}
