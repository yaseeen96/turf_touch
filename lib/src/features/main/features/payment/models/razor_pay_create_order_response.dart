
class RazorPayCreateOrderResponse {
  String? id;
  String? entity;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  String? receipt;
  dynamic offerId;
  String? status;
  int? attempts;
  List<dynamic>? notes;
  int? createdAt;

  RazorPayCreateOrderResponse({this.id, this.entity, this.amount, this.amountPaid, this.amountDue, this.currency, this.receipt, this.offerId, this.status, this.attempts, this.notes, this.createdAt});

  RazorPayCreateOrderResponse.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["entity"] is String) {
      entity = json["entity"];
    }
    if(json["amount"] is int) {
      amount = json["amount"];
    }
    if(json["amount_paid"] is int) {
      amountPaid = json["amount_paid"];
    }
    if(json["amount_due"] is int) {
      amountDue = json["amount_due"];
    }
    if(json["currency"] is String) {
      currency = json["currency"];
    }
    if(json["receipt"] is String) {
      receipt = json["receipt"];
    }
    offerId = json["offer_id"];
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["attempts"] is int) {
      attempts = json["attempts"];
    }
    if(json["notes"] is List) {
      notes = json["notes"] ?? [];
    }
    if(json["created_at"] is int) {
      createdAt = json["created_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["entity"] = entity;
    _data["amount"] = amount;
    _data["amount_paid"] = amountPaid;
    _data["amount_due"] = amountDue;
    _data["currency"] = currency;
    _data["receipt"] = receipt;
    _data["offer_id"] = offerId;
    _data["status"] = status;
    _data["attempts"] = attempts;
    if(notes != null) {
      _data["notes"] = notes;
    }
    _data["created_at"] = createdAt;
    return _data;
  }
}