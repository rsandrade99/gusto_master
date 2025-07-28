/// Capitaliza la primera letra de un string.
/// Ejemplo: "pikachu" => "Pikachu"
String capitalize(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
