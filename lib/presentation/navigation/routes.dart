enum Routes {
  dashboard('dashboard'),
  lineChart('line_chart'),
  scatterChart('scatter_chart'),
  topChart('top_chart');

  final String name;

  const Routes(this.name);
}
