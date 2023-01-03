class AppException implements Exception {
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);
}

class FetchDataException extends AppException {

  FetchDataException(message) :
  super(message, 'Error During Communication');

}

class BadRequestException extends AppException {
  BadRequestException(message) :
    super(message, 'Bad Request');
}