import 'dart:math';
import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../utils/sound_player.dart';
import '../widgets/animal_image.dart';
import '../widgets/result_message.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final SoundPlayer _soundPlayer = SoundPlayer();

  final List<Animal> animales = [
    Animal(
      nombre: 'perro',
      sonido: 'sounds/perro.mp3',
      imagen: 'assets/images/perro.png',
    ),
    Animal(
      nombre: 'gato',
      sonido: 'sounds/gato.mp3',
      imagen: 'assets/images/gato.png',
    ),
    Animal(
      nombre: 'loro',
      sonido: 'sounds/loro.mp3',
      imagen: 'assets/images/loro.png',
    ),
    Animal(
      nombre: 'vaca',
      sonido: 'sounds/vaca.mp3',
      imagen: 'assets/images/vaca.png',
    ),
  ];

  late Animal animalActual;
  bool mostrarResultado = false;
  bool respuestaCorrecta = false;
  final List<Animal> animalesUsados = [];

  @override
  void initState() {
    super.initState();
    seleccionarAnimal();
  }

  void seleccionarAnimal() {
    final restantes =
        animales.where((a) => !animalesUsados.contains(a)).toList();

    if (restantes.isEmpty) {
      setState(() {
        mostrarResultado = true;
        respuestaCorrecta = false;
        animalActual = Animal(nombre: '', sonido: '', imagen: '');
      });
      return;
    }

    final random = Random();
    animalActual = restantes[random.nextInt(restantes.length)];
    _controller.clear();
    mostrarResultado = false;
    respuestaCorrecta = false;
  }

  void verificarRespuesta() {
    setState(() {
      final respuesta = _controller.text.toLowerCase().trim();
      respuestaCorrecta = respuesta == animalActual.nombre;
      mostrarResultado = true;

      if (respuestaCorrecta) {
        animalesUsados.add(animalActual);
      }
    });
  }

  void reproducirSonido() {
    _soundPlayer.play(animalActual.sonido);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adivina el Sonido')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('¿Qué animal es?'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: reproducirSonido,
              child: const Text('Reproducir sonido'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Tu respuesta'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: verificarRespuesta,
              child: const Text('Verificar'),
            ),
            const SizedBox(height: 20),

            // Resultado de la verificación
            if (mostrarResultado)
              respuestaCorrecta
                  ? Column(
                    children: [
                      AnimalImage(imagePath: animalActual.imagen),
                      ResultMessage(
                        message: '¡Correcto! Es un ${animalActual.nombre}.',
                      ),
                    ],
                  )
                  : const ResultMessage(
                    message: '¡Incorrecto! Inténtalo de nuevo.',
                  ),

            const SizedBox(height: 20),

            // Botón para el siguiente animal (solo si hay más disponibles)
            if (mostrarResultado &&
                respuestaCorrecta &&
                animalesUsados.length < animales.length)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    seleccionarAnimal();
                  });
                },
                child: const Text('Adivinar el siguiente animal'),
              ),

            // Mensaje si ya adivinó todos los animales
            if (animalesUsados.length == animales.length)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  '¡Felicidades! Has adivinado todos los animales.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
