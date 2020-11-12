import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'device.dart';
import 'onesignal.dart';
import 'secure.dart';
import 'variable.dart';

String signature;
String deviceId;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await cekDeviceInfo();
  await initSecureStorage();
  await initOneSignal();
  signature = await getStorageValue('signature');
  deviceId = await getStorageValue('deviceId');
  runApp(UltisendApp());
}

class UltisendApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ultisend',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UltisendPage(),
    );
  }
}

class UltisendPage extends StatefulWidget {
  UltisendPage({Key key}) : super(key: key);

  @override
  _UltisendPageState createState() => _UltisendPageState();
}
class _UltisendPageState extends State<UltisendPage> {
  final _flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void dispose() {
    _flutterWebviewPlugin.dispose();
    _flutterWebviewPlugin.close();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _flutterWebviewPlugin.onStateChanged.listen((state) async {
        if (state.type == WebViewState.finishLoad) {
          _flutterWebviewPlugin.evalJavascript('''localStorage.setItem('signatureUltisend',"$signature")''');
          _flutterWebviewPlugin.evalJavascript('''localStorage.setItem('deviceIdUltisend',"$deviceId")''');
          _flutterWebviewPlugin.evalJavascript('''localStorage.setItem('externalIdDevice',"$externalID")''');
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebviewScaffold(
          url: url + ':8100/app?v=1&flowEntry=ultisend&continue='+url+':8100',
          headers: {
            "signature": signature
          },
          withJavascript: true,
          withLocalStorage: true,
          resizeToAvoidBottomInset: true)
    );
  }
}
