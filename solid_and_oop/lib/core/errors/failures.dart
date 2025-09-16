abstract class Failure {
  final String message;
  const Failure(this.message);
}

class LocalDataFailure extends Failure {
  const LocalDataFailure(super.message);
}