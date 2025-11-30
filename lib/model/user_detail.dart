import 'package:json_annotation/json_annotation.dart';

part 'user_detail.g.dart';

@JsonSerializable()
class UserDetail {
  const UserDetail({
    required this.name,
    this.profilePicture = "",
    required this.email,
    this.phoneNumber = "",
    this.address = "",
    this.occupation = "",
  });

  final String name;
  final String profilePicture;
  final String email;
  final String phoneNumber;
  final String address;
  final String occupation;

  factory UserDetail.fromJson(Map<String, dynamic> json) =>
      _$UserDetailFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailToJson(this);
}
