
import 'package:eodhd_view_monitor/data/datasources/socket/socket_datasource.dart';
import 'package:eodhd_view_monitor/data/repositories/crypto_repository_impl.dart';
import 'package:eodhd_view_monitor/domain/repositories/crypto_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../domain/usecases/get_crypto_usecase.dart';
import '../../presentation/blocs/crypto_bloc.dart';
import '../env/env.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocketDataSource>(
      () => SocketDataSourceImpl(),
      fenix: true,
    );

    Get.lazyPut<CryptoRepository>(
      () => CryptoRepositoryImpl(
        webSocketDataSource: Get.find<SocketDataSource>(),
      ),
      fenix: true,
    );

    Get.lazyPut<SocketUseCase>(
      () => SocketUseCase(
        repository: Get.find<CryptoRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<CryptoSocketBloc>(
      () => CryptoSocketBloc(
        useCase: Get.find<SocketUseCase>(),
        symbols: symbols
      ),
      fenix: true,
    );
  }
}
