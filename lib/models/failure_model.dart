import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String code;
  final String message;

  Failure({this.code = '', this.message = ''});
  bool get stringify => true;
  @override
  List<Object> get props => [code, message];
}
