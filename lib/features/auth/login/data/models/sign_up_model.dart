
import '../../domain/entites/sign_up_entity.dart';

class SignUpModel extends SignUpEntity {
  const SignUpModel({
    super.id,
    super.email,
    super.name,
    super.role,
    super.avatar,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}