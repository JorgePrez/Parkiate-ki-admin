// To parse this JSON data, do
//
//     final parkingslots = parkingslotsFromJson(jsonString);

import 'dart:convert';

Parkingslots parkingslotsFromJson(String str) => Parkingslots.fromJson(json.decode(str));

String parkingslotsToJson(Parkingslots data) => json.encode(data.toJson());

class Parkingslots {
    Parkingslots({
        this.p1,
        this.p2,
        this.p3,
        this.p4,
        this.p5,
    });

    bool p1;
    bool p2;
    bool p3;
    bool p4;
    bool p5;

    factory Parkingslots.fromJson(Map<String, dynamic> json) => Parkingslots(
        p1: json["p1"],
        p2: json["p2"],
        p3: json["p3"],
        p4: json["p4"],
        p5: json["p5"],
    );

    Map<String, dynamic> toJson() => {
        "p1": p1,
        "p2": p2,
        "p3": p3,
        "p4": p4,
        "p5": p5,
    };
}
