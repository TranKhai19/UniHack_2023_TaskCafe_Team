double uucpCalculator(
    int simpleUseCase, int averageUseCase, int complexUseCase) {
  const simpleWeight = 5;
  const averageWeight = 10;
  const complexWeight = 15;

  final uucp = (simpleWeight * simpleUseCase) +
      (averageWeight * averageUseCase) +
      (complexWeight * complexUseCase);

  return uucp.toDouble();
}
