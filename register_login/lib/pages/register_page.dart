// Importamos los paquetes y archivos necesarios
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart'; // Estado global de la aplicación
import '../widgets/custom_button.dart'; // Nuestro botón personalizado
import '../widgets/user_icon.dart'; // Icono de usuario circular
import '../widgets/password_field.dart'; // Campo de contraseña con toggle
import '../utils/validators.dart'; // Funciones para validar datos

// Página de registro - Stateless porque no maneja estado interno complejo
class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  // Controladores para manejar los textos ingresados por el usuario
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Contenedor con fondo degradado azul a rojo
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment
              .bottomRight, // El degradado empieza en la esquina superior derecha
          end: Alignment.topLeft, // Y termina en la esquina inferior izquierda
          colors: [
            Color(0xFF351b4b),
            Color(0xFF1b5b7e),
          ], // Colores del degradado
        ),
      ),
      // Scaffold para la estructura básica de la página
      child: Scaffold(
        backgroundColor:
            Colors.transparent, // Fondo transparente para ver el degradado
        body: SafeArea(
          // Evita que el contenido quede bajo barras del sistema
          child: SingleChildScrollView(
            // Permite hacer scroll si el contenido es largo
            child: Padding(
              padding: const EdgeInsets.all(32.0), // Margen interno general
              child: Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centra verticalmente
                  children: [
                    const SizedBox(height: 60), // Espacio en blanco superior
                    // Icono de usuario con el ícono de "persona agregada"
                    const UserIcon(iconData: Icons.person_add),
                    const SizedBox(height: 50), // Espacio después del ícono
                    // Campo para nombre de usuario
                    _inputField("Username", usernameController),
                    const SizedBox(height: 20), // Espacio entre campos
                    // Campo de contraseña (usando nuestro widget personalizado)
                    PasswordField(
                      controller: passwordController,
                      hintText: "Password",
                    ),
                    const SizedBox(height: 20),

                    // Campo para confirmar contraseña
                    PasswordField(
                      controller: confirmController,
                      hintText: "Confirm Password",
                    ),
                    const SizedBox(height: 20),

                    // Botón de registro
                    CustomButton(
                      text: "Register",
                      onPressed: () {
                        // Validamos los datos antes de registrar:
                        // 1. Usuario válido
                        // 2. Contraseña válida
                        // 3. Las contraseñas coinciden
                        if (!isValidUsername(usernameController.text) ||
                            !isValidPassword(passwordController.text) ||
                            passwordController.text != confirmController.text) {
                          // Mostramos mensaje de error si algo falla
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Por favor, revisa tus datos..."),
                            ),
                          );
                          return; // Detenemos el proceso si hay errores
                        }
                        // Si todo está bien, mostramos en consola (luego se cambiará por lógica real)
                        debugPrint(
                          "Registered Username: ${usernameController.text}",
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    // Botón para ir al login (si ya tiene cuenta)
                    TextButton(
                      onPressed: () => context.read<AppState>().goToLogin(),
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 30), // Espacio final
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Función auxiliar que crea campos de texto con estilo consistente
  Widget _inputField(
    String hintText,
    TextEditingController controller, {
    bool isPassword = false, // Por defecto no es campo de contraseña
  }) {
    // Configuración del borde del campo de texto
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18), // Bordes redondeados
      borderSide: const BorderSide(color: Colors.white), // Borde blanco
    );

    return TextField(
      style: const TextStyle(color: Colors.white), // Texto en blanco
      controller: controller, // Vincula el controlador para manejar el texto
      decoration: InputDecoration(
        hintText: hintText, // Texto de sugerencia
        hintStyle: const TextStyle(color: Colors.white), // Color del hint
        enabledBorder: border, // Borde cuando no está enfocado
        focusedBorder: border, // Borde cuando está seleccionado
      ),
      obscureText: isPassword, // Si es true, oculta el texto (para contraseñas)
    );
  }
}
