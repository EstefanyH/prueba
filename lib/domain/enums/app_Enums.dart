enum CiaType {
  name,
  ruc,
  latitud,
  longitud,
  comment
}

enum PhotoType {
  camera(1),
  gallery(2);

  final int value;
  const PhotoType(this.value);
}

enum PhotoSide {
  front,
  left,
  right
}