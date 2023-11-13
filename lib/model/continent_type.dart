enum ContinentType {
  all(0, "All", "All"),
  pacific(1, "Pacific", "Pacific"),
  atlantic(2, "Atlantic", "Atlantic"),
  indian(3, "Indian", "Indian"),
  antarctica(4, "Antarctica", "Antarctica"),
  america(5, "America", "America"),
  us(6, "US", "US"),
  europe(7, "Europe", "Europe"),
  asia(8, "Asia", "Asia"),
  africa(9, "Africa", "Africa"),
  australia(10, "Australia", "Australia"),
  empty(99, "", "");

  final int no;
  final String code;
  final String name;

  const ContinentType(this.no, this.code, this.name);
}
