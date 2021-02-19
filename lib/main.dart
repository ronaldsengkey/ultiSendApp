import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'device.dart';
import 'onesignal.dart';
import 'secure.dart';

String signature;
String deviceId;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const bool isProduction = bool.fromEnvironment('dart.vm.product');
  await DotEnv.load(fileName: isProduction ? ".env.production" : ".env.local");
  await cekDeviceInfo();
  await initSecureStorage(DotEnv.env['SIGNATURE']);
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
          url: DotEnv.env['DASHBOARD_LINK'] + ':' + DotEnv.env['DASHBOARD_PORT'] + '/app?v='+DotEnv.env['VERSION']+'&flowEntry='+DotEnv.env['FLOWENTRY']+'&continue='+DotEnv.env['DASHBOARD_LINK']+':' + DotEnv.env['DASHBOARD_PORT'],
          headers: {
            "signature": signature
          },
          withJavascript: true,
          withLocalStorage: true,
          resizeToAvoidBottomInset: true)
    );
  }
}
