double tcfCalculate(
int t1, int t2, int t3,
int t4, int t5, int t6,
int t7, int t8, int t9,
int t10, int t11, int
t12, int t13,
){
  const t1Weight = 2;
  const t2Weight = 1;
  const t3Weight = 1;
  const t4Weight = 1;
  const t5Weight = 1;
  const t6Weight = 0.5;
  const t7Weight = 0.5;
  const t8Weight = 2;
  const t9Weight = 1;
  const t10Weight = 1;
  const t11Weight = 1;
  const t12Weight = 1;
  const t13Weight = 1;
  final tcf = 0.6 *((
      (t1*t1Weight) + (t2*t2Weight) + (t3*t3Weight) + (t4*t4Weight)
      +(t5*t5Weight) + (t6*t6Weight) + (t7*t7Weight) + (t8*t8Weight) + (t9*t9Weight)
      + (t10*t10Weight) + (t11*t11Weight) + (t12*t12Weight) + (t13*t13Weight)
  )/100);
  return tcf.toDouble();
}