import 'package:aventones/models/address.dart';

class Trip {

  Trip(Address origin, Address destination, DateTime dateTime,
      int numberOfAvailableSeats, double pricePerSeat){
    this.origin = origin;
    this. destination = destination;
    this.dateTime = dateTime;
    this.numberOfAvailableSeats = numberOfAvailableSeats;
    this.pricePerSeat = pricePerSeat;
  }

  Address origin;
  Address destination;
  DateTime dateTime;
  int numberOfAvailableSeats;
  double pricePerSeat;
}