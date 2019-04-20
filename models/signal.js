var mongoose = require('mongoose');

var readingSchema = new mongoose.Schema({
  MODEL:        String,
  IMEI:         Number,
  C_CSQ:        Number,
  C_MODE:       String,
  C_COUNTRY:    Number,
  C_OPERATOR:   Number,
  C_STATION:    String,
  C_CELL:       String,
  P_STATUS:     Number,
  P_LEVEL:      Number,
  UTC_TIME:     String,
  ACQUSITION:   Boolean,
  LATITUDE:     Number,
  LONGITUDE:    Number,
  KNOT:         Number,
  COURSE:       Number,
  UTC_DATE:     String,
  THE_ADDRESS:  String,
  THE_UTC_TIMESTAMP: Number});

var ackSchema = new mongoose.Schema({
  MODEL:        String,
  IMEI:         Number,
  ACK:          String,
  ITEM:         String,
  STATUS:       String,
  THE_UTC_TIMESTAMP:  Date});

//mongoose models (collection name automatically created with postfix "s")
var Signal_reading = module.exports = mongoose.model('sginal_reading', readingSchema);
var Signal_ack = module.exports = mongoose.model('signal_ack', ackSchema) ;

module.exports.mongo_saveOneReading = function (reading) {
    thisReading = new Signal_reading(reading); 
    thisReading.save(function (err, reading) {
      if (err) {
        console.log("save error: %s", err);Signal_reading=null;
      }
      else {
        console.log("mongoose: saved reading: %s", JSON.stringify(reading));
      }
    });
};

module.exports.mongo_saveOneAck = function (ack) {
    thisACK = new Signal_ack(ack); 
    thisACK.save(function (err, ack) {
      if (err) {
        console.log("save error: %s", err);
      }
      else {
        console.log("mongoose: saved ack: %s", JSON.stringify(ack));
      }
    });
};
