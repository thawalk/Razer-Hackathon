class MambuException implements Exception {
  final int returnCode;
  final String returnStatus;
  MambuException(this.returnCode, this.returnStatus);
}