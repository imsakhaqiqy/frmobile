import 'dart:io';

import 'package:camera/camera.dart';
import 'package:field_recruitment/constans.dart';
import 'package:flutter/material.dart';

class CameraVisitScreen extends StatefulWidget {
  @override
  _CameraVisitScreenState createState() => _CameraVisitScreenState();
}

class _CameraVisitScreenState extends State<CameraVisitScreen> {
  late CameraController controller;
  List<CameraDescription> cameras = [];
  int selectedCamera = 1;
  Future initializeCamera() async {
    cameras = await availableCameras();
    controller =
        CameraController(cameras[selectedCamera], ResolutionPreset.medium);
    await controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<File?> takePicture() async {
    // Directory root = await getTemporaryDirectory();
    // String directoryPath = '${root.path}/Guided_Camera';
    // await Directory(directoryPath).create(recursive: true);
    // String filePath = '$directoryPath/${DateTime.now()}.jpg';
    var xFile;
    try {
      xFile = await controller.takePicture();
    } catch (e) {
      return null;
    }

    return File(xFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: initializeCamera(),
            builder: (_, snapshot) => (snapshot.connectionState ==
                    ConnectionState.done)
                ? Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width *
                                controller.value.aspectRatio,
                            child: CameraPreview(controller),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: RaisedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedCamera =
                                            selectedCamera == 0 ? 1 : 0;
                                      });
                                    },
                                    shape: CircleBorder(),
                                    color: Colors.white,
                                    child: Icon(Icons.cameraswitch),
                                  ),
                                ),
                                Container(
                                  width: 70,
                                  height: 70,
                                  margin: EdgeInsets.only(top: 50),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      if (!controller.value.isTakingPicture) {
                                        File? result = await takePicture();
                                        Navigator.pop(context, result);
                                      }
                                    },
                                    shape: CircleBorder(),
                                    color: Colors.blue,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width *
                            controller.value.aspectRatio,
                      ),
                    ],
                  )
                : Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  )));
  }
}
