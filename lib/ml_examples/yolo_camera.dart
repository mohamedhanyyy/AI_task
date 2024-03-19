import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ObjectDetectionScreen extends StatefulWidget {
  const ObjectDetectionScreen({super.key});

  @override
  ObjectDetectionScreenState createState() => ObjectDetectionScreenState();
}

class ObjectDetectionScreenState extends State<ObjectDetectionScreen> {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  Interpreter? _interpreter;
  bool _isModelLoaded = false;

  @override
  void initState() {
    super.initState();
    loadModel();
    setupCamera();
  }

  Future<void> loadModel() async {
    try {
      final interpreterOptions = InterpreterOptions()..threads = 4;
      _interpreter = await Interpreter.fromAsset('assets/yolov8.tflite',
          options: interpreterOptions);
      setState(() {
        _isModelLoaded = true;
      });
    } catch (e) {
      debugPrint('Failed to load model: $e');
    }
  }

  Future<void> setupCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    await _cameraController?.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
    _cameraController?.startImageStream((CameraImage image) {
      if (_isModelLoaded) {
        processCameraImage(image);
      }
    });
  }

  void processCameraImage(CameraImage image) async {
    try {
      final int startTime = DateTime.now().millisecondsSinceEpoch;
      final int endTime = DateTime.now().millisecondsSinceEpoch;
      debugPrint('Inference time: ${endTime - startTime}ms');
    } catch (e) {
      debugPrint('Failed to process camera image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController?.value.isInitialized == false) {
      return Container(color: Colors.white);
    }
    if (_cameraController == null) {
      return Container(color: Colors.white);
    }
    return Scaffold(
      body: Stack(
        children: [
          AspectRatio(
            aspectRatio: _cameraController?.value.aspectRatio ?? 1,
            child: CameraPreview(_cameraController!),
          ),
      
          Positioned(top: 50,child: Text('${_interpreter?.getOutputTensor(0)??0}',style: const TextStyle(
            fontSize: 15,fontWeight: FontWeight.bold
          ),))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _interpreter?.close();
    super.dispose();
  }
}
