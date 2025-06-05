// Valida si un nombre de usuario cumple con los requisitos mínimos
bool isValidUsername(String username) {
  // Retorna true solo si:
  // 1. El username NO está vacío (isNotEmpty)
  // 2. Y tiene al menos 3 caracteres de longitud (length >= 3)
  return username.isNotEmpty && username.length >= 3;
}

// Valida si una contraseña cumple con los requisitos de seguridad básicos
bool isValidPassword(String password) {
  // Retorna true solo si:
  // 1. La contraseña NO está vacía (isNotEmpty)
  // 2. Y tiene al menos 6 caracteres de longitud (length >= 6)
  return password.isNotEmpty && password.length >= 6;
}
