import 'dart:html';
import 'package:flutter/material.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void uploadVideo({required Function(File file) onSelected}){
      FileUploadInputElement uploadInput = FileUploadInputElement()..accept = 'video/*';
      uploadInput.click();
      uploadInput.onChange.listen((event) {
        final file = uploadInput.files?.first;
        final reader = FileReader();

        //reader.readAsDataUrl(file!);
        //convert tu array buffer
        reader.readAsArrayBuffer(file!);

        final arrayBuffer = reader.result; 

        reader.onLoadEnd.listen((event) {
          print(arrayBuffer);
          onSelected(file);
        });
      });
    }

    void uploadToIpfs(){
      final dateTime = DateTime.now();
      const userAddress = '0x00000';
      const path = '';

      uploadVideo(onSelected: (File file) {

       });
    }
    
    return Padding(
      padding: const EdgeInsets.all(27),
      child: Form(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //UPLOAD VIDEO
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () => uploadToIpfs(),

                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.3,
                  child: const Icon(
                    Icons.upload_rounded,
                    color: Color(0xff024373),
                    size: 50,
                  )
                  ),
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    decoration: const InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff615B57))),
                  ),

                  const SizedBox(height: 8,),

                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    decoration: const InputDecoration(
                        hintText: 'Description',
                        hintStyle: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff615B57)),
                        enabled: true,
                        border: InputBorder.none),
                  ),

                  const SizedBox(height: 8,),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Text(
                            'Upload',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          Icon(Icons.upload_rounded)
                        ],
                      )
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}