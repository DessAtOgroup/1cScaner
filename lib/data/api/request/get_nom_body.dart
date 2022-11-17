class GetNomBody {
  final String barcode;

  GetNomBody({
    required this.barcode,
  });

  Map<String, String> toApi() {
    return {
      'barcode': barcode,
    };
  }
}
