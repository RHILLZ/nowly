class QuickResponse{
  final String message;
  QuickResponse({required this.message});

  static final  List<QuickResponse> quickResponses = [
    QuickResponse(message : '5 minutes'),
    QuickResponse(message : 'I’m looking for you'),
    QuickResponse(message : 'Wave your hands'),
    QuickResponse(message : '15 minutes'),
    QuickResponse(message : 'Can’t find parking')
  ];
}