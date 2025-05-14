import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ImagePickerPage(),
    );
  }
}

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  // 선택된 이미지 파일을 저장할 변수
  File? _image;

  // image_picker 인스턴스 생성
  final ImagePicker _picker = ImagePicker();

  // 갤러리에서 이미지 선택 메서드
  Future<void> _pickImage() async {
    // pickImage: gallery에서 이미지를 고르는 내장 함수
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,     // (선택) 이미지 최대 가로 크기
      maxHeight: 600,    // (선택) 이미지 최대 세로 크기
      imageQuality: 80,  // (선택) 0~100, 100이 최고 화질
    );

    // 사용자가 이미지를 선택했으면
    if (pickedFile != null) {
      setState(() {
        // XFile.path는 이미지 파일의 실제 경로
        _image = File(pickedFile.path);
      });
    } else {
      // 선택을 취소했을 때 (디버깅용)
      debugPrint('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('갤러리에서 사진 선택하기')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 이미지가 선택되었으면 보여주고, 아니면 안내 텍스트
            _image != null
                ? Image.file(_image!, width: 300, height: 300, fit: BoxFit.cover)
                : const Text('선택된 이미지가 없습니다.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('갤러리에서 사진 선택'),
            ),
          ],
        ),
      ),
    );
  }
}
