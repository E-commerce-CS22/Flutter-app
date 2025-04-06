class Failure {
  final String errMessage;
  Failure({required this.errMessage});
}


class ServerFailure extends Failure {
  ServerFailure({required String errMessage}) : super(errMessage: errMessage);
}

