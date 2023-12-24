import 'dart:convert';
import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../web3_internal/constants.dart';

part 'data_nft.freezed.dart';

@freezed
class DataNFTPermissions with _$DataNFTPermissions {
  const factory DataNFTPermissions.manager() = Manager;
  const factory DataNFTPermissions.deployDatatoken() = DeployDatatoken;
  const factory DataNFTPermissions.updateMetadata() = UpdateMetadata;
  const factory DataNFTPermissions.store() = Store;
}

@freezed
class MetadataState with _$MetadataState {
  const factory MetadataState.active() = Active;
  const factory MetadataState.endOfLife() = EndOfLife;
  const factory MetadataState.deprecated() = Deprecated;
  const factory MetadataState.revoked() = Revoked;
  const factory MetadataState.temporarilyDisabled() = TemporarilyDisabled;
}

@freezed
class Flags with _$Flags {
  const factory Flags.plain() = Plain;
  const factory Flags.compressed() = Compressed;
  const factory Flags.encrypted() = Encrypted;

  Uint8List toByte() {
    return Uint8List.fromList([index]);
  }
}

@freezed
class DataNFTArguments with _$DataNFTArguments {
  const factory DataNFTArguments({
    required String name,
    required String symbol,
    int? templateIndex,
    String? additionalDatatokenDeployer,
    String? additionalMetadataUpdater,
    String? uri,
    bool? transferable,
    String? owner,
  }) = _DataNFTArguments;

  factory DataNFTArguments.fromJson(Map<String, dynamic> json) =>
      _$DataNFTArgumentsFromJson(json);

  String get defaultTokenUri =>
      'data:application/json;base64,${base64Encode(jsonEncode({
            'name': name,
            'symbol': symbol,
            'background_color': '141414',
            'image_data':
                'data:image/svg+xml,%3Csvg viewBox=\'0 0 99 99\' fill=\'undefined\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cpath fill=\'%23ff409277\' d=\'M0,99L0,29C9,24 19,19 31,19C42,18 55,23 67,25C78,26 88,23 99,21L99,99Z\'/%3E%3Cpath fill=\'%23ff4092bb\' d=\'M0,99L0,43C9,45 18,47 30,48C41,48 54,46 66,45C77,43 88,43 99,43L99,99Z\'%3E%3C/path%3E%3Cpath fill=\'%23ff4092ff\' d=\'M0,99L0,78C10,75 20,72 31,71C41,69 53,69 65,70C76,70 87,72 99,74L99,99Z\'%3E%3C/path%3E%3C/svg%3E',
          }).codeUnits)}';

  factory DataNFTArguments.fromDefault({
    required String name,
    required String symbol,
    int templateIndex = 1,
    String additionalDatatokenDeployer = ZERO_ADDRESS,
    String additionalMetadataUpdater = ZERO_ADDRESS,
    String? uri,
    bool transferable = true,
    String? owner,
  }) =>
      DataNFTArguments(
        name: name,
        symbol: symbol,
        templateIndex: templateIndex,
        additionalDatatokenDeployer: additionalDatatokenDeployer,
        additionalMetadataUpdater: additionalMetadataUpdater,
        uri: uri ?? defaultTokenUri,
        transferable: transferable,
        owner: owner,
      );
}

@freezed
class DataNFT with _$DataNFT {
  const factory DataNFT({
    required String name,
    required String symbol,
    int? templateIndex,
    String? additionalDatatokenDeployer,
    String? additionalMetadataUpdater,
    String? uri,
    bool? transferable,
    String? owner,
  }) = _DataNFT;
}

extension DataNFTExtension on DataNFT {
  Future<DataNFT> deployContract(
      Map<String, dynamic> configDict, Map<String, dynamic> txDict) async {
    final address =
        get_address_of_type(configDict, DataNFTFactoryContract.CONTRACT_NAME);
    final dataNFTFactory = DataNFTFactoryContract(configDict, address);

    final walletAddress = get_from_address(txDict);

    final receipt = await dataNFTFactory.deployERC721Contract(
      name,
      symbol,
      templateIndex ?? 1,
      additionalMetadataUpdater ?? ZERO_ADDRESS,
      additionalDatatokenDeployer ?? ZERO_ADDRESS,
      uri ?? defaultTokenUri,
      transferable ?? true,
      owner ?? walletAddress,
      txDict,
    );

    final registeredEvent =
        dataNFTFactory.contract.events.NFTCreated().processReceipt(
              receipt,
              errors: DISCARD,
            )[0];
    final dataNFTAddress = registeredEvent.args['newTokenAddress'];

    return DataNFT(
      name: name,
      symbol: symbol,
      templateIndex: templateIndex,
      additionalDatatokenDeployer: additionalDatatokenDeployer,
      additionalMetadataUpdater: additionalMetadataUpdater,
      uri: uri,
      transferable: transferable,
      owner: owner,
    );
  }
}
