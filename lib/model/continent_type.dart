enum ContinentType {
  pacific(0, "Pacific", "Pacific"),
  atlantic(1, "Atlantic", "Atlantic"),
  indian(2, "Indian", "Indian"),
  america(3, "America", "America"),
  us(4, "US", "US"),
  europe(5, "Europe", "Europe"),
  asia(6, "Asia", "Asia"),
  africa(7, "Africa", "Africa"),
  australia(8, "Australia", "Australia"),
  empty(99, "", "");

  final int no;
  final String code;
  final String name;

  const ContinentType(this.no, this.code, this.name);
}
