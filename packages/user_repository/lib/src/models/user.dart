import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? userName;
  final String? email;
  final String? photoUrl;

  const User({this.id, this.userName, this.email, this.photoUrl = ''});

  @override
  List<Object?> get props => [id];
  static const empty = User(id: '', userName: '', email: '', photoUrl: '');

  bool get isNotEmpty => this != User.empty;
}
