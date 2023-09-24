class RootInfo {
  String? tag;
  String? rootNamespaceId;
  String? homeNamespaceId;

  RootInfo(this.tag, this.rootNamespaceId, this.homeNamespaceId);

  RootInfo.fromMap(Map<String, dynamic> json) {
    tag = json[".tag"];
    rootNamespaceId = json["root_namespace_id"];
    homeNamespaceId = json["home_namespace_id"];
  }

  Map<String, dynamic> toMap() {
    return {
      ".tag": tag,
      "root_namespace_id": rootNamespaceId,
      "home_namespace_id": homeNamespaceId,
    };
  }
}
