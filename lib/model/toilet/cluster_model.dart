class Cluster {
  final int id;
  final String clusterName;
  final String clusterCode;

  Cluster({
    required this.id,
    required this.clusterName,
    required this.clusterCode,
  });

  // Factory constructor to create a Cluster instance from a JSON object
 

  factory Cluster.fromJson(Map<String, dynamic> json) {
    return Cluster(
      id: json['id'],
      clusterName: json['cluster_name'], // Map to cluster_name
      clusterCode: json['cluster_code'],
    );
  }

  // Method to convert a Cluster instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cluster_name': clusterName,
      'cluster_code': clusterCode,
    };
  }
}
