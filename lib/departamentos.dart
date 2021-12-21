class Usuario {
  String departamento;

  static const String collectionId = 'usuarios';
  Usuario({
    required this.departamento,
  });

  Usuario.fromSnapshot(String departamento, Map<String, dynamic> usuario)
      : departamento = usuario['departamentos'];

  Map<String, dynamic> toMap() => {
        'departamentos': departamento,
      };

  @override
  String toString() {
    return 'Usuario{ departamentos: $departamento}';
  }
}
