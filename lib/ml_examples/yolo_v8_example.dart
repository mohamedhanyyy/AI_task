import 'package:flutter/material.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

class ObjectDetectionExample extends StatefulWidget {
  const ObjectDetectionExample({super.key});

  @override
  State<ObjectDetectionExample> createState() => _ObjectDetectionExampleState();
}

class _ObjectDetectionExampleState extends State<ObjectDetectionExample> {
  ModelObjectDetection? objectModel;
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    objectModel = await PytorchLite.loadObjectDetectionModel(
        "assets/models/yolov8s.torchscript", 80, 640, 640,
        labelPath: "assets/labels/labels_objectDetection_Coco.txt",
        objectDetectionModelType: ObjectDetectionModelType.yolov5);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/8K-test.jpg'),
          Text(
            'Objects length: ${objectModel?.labels.length}',
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Flexible(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return Text(
                    '${index + 1}-  ${objectModel?.labels[index]}',
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                  );
                },
                shrinkWrap: true,
                itemCount: objectModel?.labels.length),
          ),
        ],
      ),
    );
  }
}
