import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class EarthARExample extends StatefulWidget {
  const EarthARExample({super.key});

  @override
  State<EarthARExample> createState() => _EarthARExampleState();
}

class _EarthARExampleState extends State<EarthARExample> {
  ArCoreController? arCoreController;

  void onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    earthMap(arCoreController!);
  }

  earthMap(ArCoreController coreController) async {
    final ByteData earthMap = await rootBundle.load("assets/img.png");

    final material = ArCoreMaterial(
        color: Colors.white, textureBytes: earthMap.buffer.asUint8List());

    final sphere = ArCoreSphere(
      materials: [material],
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector64.Vector3(0, 0, -1.5),
    );
    arCoreController!.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(onArCoreViewCreated: onArCoreViewCreated),
    );
  }
}
