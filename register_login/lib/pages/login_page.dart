// Importamos todos los paquetes y widgets necesarios
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart'; // Donde guardamos el estado global de la app
import '../widgets/custom_button.dart'; // Botón personalizado que reutilizamos
import '../widgets/user_icon.dart'; // Icono de usuario con diseño circular
import '../widgets/password_field.dart'; // Campo de contraseña con opción para mostrar/ocultar
import '../utils/validators.dart'; // Funciones para validar usuario y contraseña

// Definimos la página de Login como un StatefulWidget porque maneja su propio estado
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Clase que contiene la lógica y la interfaz de la página de login
class _LoginPageState extends State<LoginPage> {
  // Controladores para manejar lo que el usuario escribe en los campos
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // La página tiene un fondo con degradado de colores
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment
              .bottomRight, // El degradado empieza en la esquina superior derecha
          end: Alignment.topLeft, // Y termina en la esquina inferior izquierda
          colors: [
            Color(0xFF351b4b),
            Color(0xFF1b5b7e),
          ], // Colores del degradado: azul a rojo
        ),
      ),
      // Usamos Scaffold para la estructura básica de la página
      child: Scaffold(
        backgroundColor: const Color(
          0x00FF0000,
        ), // Hacemos transparente el fondo del Scaffold
        body: SafeArea(
          // Aseguramos que el contenido no quede detrás de notches o barras del sistema
          child: SingleChildScrollView(
            // Permite hacer scroll si el contenido es muy largo
            child: Padding(
              padding: const EdgeInsets.all(
                32.0,
              ), // Espaciado alrededor de todo el contenido
              child: Center(
                // Centramos toda la columna de widgets
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centramos verticalmente
                  children: [
                    const SizedBox(
                      height: 60,
                    ), // Espacio en blanco arriba del icono
                    const UserIcon(), // Muestra nuestro icono de usuario personalizado
                    const SizedBox(
                      height: 50,
                    ), // Espacio entre el icono y los campos de texto
                    // Campo de texto para el nombre de usuario
                    _inputField("Username", usernameController),
                    const SizedBox(height: 20), // Espacio entre campos
                    // Campo especial para la contraseña (con opción para mostrar/ocultar)
                    PasswordField(
                      controller: passwordController,
                      hintText: "Password",
                    ),
                    const SizedBox(height: 20), // Espacio antes de los botones
                    // Fila con los dos botones principales
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centramos los botones
                      children: [
                        // Botón para iniciar sesión
                        CustomButton(
                          text: "Sign in",
                          onPressed: () {
                            // Validamos que el usuario y contraseña cumplan con los requisitos
                            if (!isValidUsername(usernameController.text) ||
                                !isValidPassword(passwordController.text)) {
                              // Si no son válidos, mostramos un mensaje de error
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Usuario o contraseña incorrecta...",
                                  ),
                                ),
                              );
                              return; // Salimos sin hacer nada más
                            }
                            // Si son válidos, imprimimos en consola (luego lo cambiaremos por lógica real)
                            debugPrint("Username: ${usernameController.text}");
                            debugPrint("Password: ${passwordController.text}");
                          },
                        ),
                        const SizedBox(width: 20), // Espacio entre botones
                        // Botón para ir al registro
                        CustomButton(
                          text: "Sign up",
                          onPressed: () =>
                              context.read<AppState>().goToRegister(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ), // Espacio pequeño después de los botones
                    // Texto de ayuda para recuperar cuenta
                    const Text(
                      "Can't access your account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 30,
                    ), // Espacio final para que no quede pegado abajo
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
    // Definimos el estilo del borde del campo de texto
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18), // Bordes redondeados
      borderSide: const BorderSide(color: Colors.white), // Borde blanco
    );

    return TextField(
      style: const TextStyle(color: Colors.white), // Texto en blanco
      controller: controller, // Conectamos el controlador para manejar el texto
      decoration: InputDecoration(
        hintText: hintText, // Texto de ayuda que desaparece al escribir
        hintStyle: const TextStyle(
          color: Colors.white,
        ), // Color del texto de ayuda
        enabledBorder: border, // Borde cuando no está seleccionado
        focusedBorder: border, // Borde cuando está seleccionado
      ),
      obscureText:
          isPassword, // Si es true, muestra puntos en vez de texto (para contraseñas)
    );
  }
}
