var mongoose = require('mongoose');

var deviceSchema = new mongoose.Schema({
  MODEL:        String,
  IMEI:         Number,
  USER:         String,
  ACTIVATED:    Boolean,
  THE_UTC_TIMESTAMP: Number});

//mongoose models (collection name automatically created with postfix "s")
var deviceModel = mongoose.model('device', deviceSchema);

module.exports = deviceModel;