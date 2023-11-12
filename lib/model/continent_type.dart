enum ContinentType {
  all(0, "All", "All"),
  pacific(1, "Pacific", "Pacific"),
  atlantic(2, "Atlantic", "Atlantic"),
  indian(3, "Indian", "Indian"),
  america(4, "America", "America"),
  us(5, "US", "US"),
  europe(6, "Europe", "Europe"),
  asia(7, "Asia", "Asia"),
  africa(8, "Africa", "Africa"),
  australia(9, "Australia", "Australia"),
  empty(99, "", "");

  final int no;
  final String code;
  final String name;

  const ContinentType(this.no, this.code, this.name);
}
