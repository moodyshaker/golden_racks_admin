class MoreModel {
  final String name;
  final dynamic route;
  final bool hasRoute;
  final String? desc;

  MoreModel(
      {required this.name,
      this.hasRoute = true,
      this.desc,
      required this.route});
}
