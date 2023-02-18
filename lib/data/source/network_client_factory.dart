import 'package:Array_App/data/source/network_client.dart';
import 'package:Array_App/dio_network_client.dart';

class NetworkClientFactory {
  static NetworkClient create() {
    return DioNetworkClient();
  }
}
