class Slot {
  final int id;
  final String name;
  final bool isAvailable;

  const Slot({this.id, this.name, this.isAvailable});

}

class SlotList {
  static List<Slot> list() {
    const data = <Slot> [
      Slot(
        id: 1,
        name: 'P1',
        isAvailable: true
      ),
      Slot(
          id: 2,
          name: 'P2',
          isAvailable: false
      ),
      Slot(
          id: 3,
          name: 'P3',
          isAvailable: false
      ),
      Slot(
          id: 4,
          name: 'P4',
          isAvailable: false
      ),
      Slot(
          id: 5,
          name: 'P5',
          isAvailable: true
      ),
     /* Slot(
          id: 6,
          name: 'P6',
          isAvailable: false
      ),
      Slot(
          id: 7,
          name: 'P7',
          isAvailable: true
      ),
      Slot(
          id: 8,
          name: 'P8',
          isAvailable: false
      ),
      Slot(
          id: 9,
          name: 'P9',
          isAvailable: false
      ),
      Slot(
          id: 10,
          name: 'P10',
          isAvailable: false
      ),
      Slot(
          id: 11,
          name: 'P11',
          isAvailable: true
      ),
      Slot(
          id: 12,
          name: 'P12',
          isAvailable: false
      ),*/
    ];
    return data;
  }

}