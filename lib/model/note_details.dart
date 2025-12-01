class NoteDetails {
  String owner;
  String claimNo;
  String inspectedBy;
  String insuranceCompany;
  String note;

  NoteDetails({
    required this.owner,
    required this.claimNo,
    required this.inspectedBy,
    required this.insuranceCompany,
    required this.note,
  });

  factory NoteDetails.empty() {
    return NoteDetails(
      owner: '',
      claimNo: '',
      inspectedBy: '',
      insuranceCompany: '',
      note: '',
    );
  }

  String toFormattedString() {
    return 'Owner: $owner\n'
        'Claim Number: $claimNo\n'
        'Inspected By: $inspectedBy\n'
        'Insurance Company: $insuranceCompany\n'
        'Note: $note\n';
  }

  NoteDetails copyWith({
    String? owner,
    String? claimNo,
    String? inspectedBy,
    String? insuranceCompany,
    String? note,
  }) {
    return NoteDetails(
      owner: owner ?? this.owner,
      claimNo: claimNo ?? this.claimNo,
      inspectedBy: inspectedBy ?? this.inspectedBy,
      insuranceCompany: insuranceCompany ?? this.insuranceCompany,
      note: note ?? this.note,
    );
  }
}