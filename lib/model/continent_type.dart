enum ContinentType {
  pacific(0, "Pacific", "Pacific"),
  atlantic(1, "Atlantic", "Atlantic"),
  indian(2, "Indian", "Indian"),
  america(3, "America", "America"),
  europe(4, "Europe", "Europe"),
  asia(5, "Asia", "Asia"),
  africa(6, "Africa", "Africa"),
  australia(7, "Australia", "Australia");

  final int no;
  final String code;
  final String name;

  const ContinentType(this.no, this.code, this.name);
}
