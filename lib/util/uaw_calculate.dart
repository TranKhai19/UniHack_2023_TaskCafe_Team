double uawCalculator(
    int simpleUseCase, int averageUseCase, int complexUseCase) {
  const simpleWeight = 1;
  const averageWeight = 2;
  const complexWeight = 3;

  final uaw = (simpleWeight * simpleUseCase) +
      (averageWeight * averageUseCase) +
      (complexWeight * complexUseCase);

  return uaw.toDouble();
}

