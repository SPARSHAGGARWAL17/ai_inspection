class UserDetails {
  String name;
  String mobileNo;
  String email;
  String city;
  String state;
  String zipCode;
  String streetAddress;

  UserDetails({
    required this.name,
    required this.mobileNo,
    required this.email,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.streetAddress,
  });

  factory UserDetails.empty() {
    return UserDetails(name: '', mobileNo: '', email: '', city: '', state: '', zipCode: '', streetAddress: '');
  }

  void copyWith({String? name, String? mobileNo, String? email, String? streetAddress, String? city, String? state, String? zipCode}) {
    if (name != null) this.name = name;
    if (mobileNo != null) this.mobileNo = mobileNo;
    if (email != null) this.email = email;
    if (streetAddress != null) this.streetAddress = streetAddress;
    if (city != null) this.city = city;
    if (state != null) this.state = state;
    if (zipCode != null) this.zipCode = zipCode;
  }

  bool isValid() {
    return name.isNotEmpty && mobileNo.isNotEmpty && streetAddress.isNotEmpty && city.isNotEmpty && state.isNotEmpty && zipCode.isNotEmpty;
  }
}
