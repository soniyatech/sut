var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var expressValidator = require('express-validator');
var flash = require('connect-flash');
var session = require('express-session');
var passport = require('passport');
//var LocalStrategy = require('passport-local').Strategy;

var root = require('./routes/root');
var users = require('./routes/users');

// init express as app
var app = express();

// view engine
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

//set static folder, make folders under public available to serve as static files
app.use(express.static(path.join(__dirname, 'public')));

// uncomment after placing your favicon in /public
app.use(favicon(path.join(__dirname, 'public', '/images/favicon6.ico')));

app.use(logger('dev'));

// bodyParser middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());

// Express Session
app.use(session({
    secret: 'j3byrcc.',
    saveUninitialized: true,
    resave: true
}));

// Passport init
app.use(passport.initialize());
app.use(passport.session());

// Express Validator
app.use(expressValidator({
  errorFormatter: function(param, msg, value) {
      var namespace = param.split('.')
      , root    = namespace.shift()
      , formParam = root;

    while(namespace.length) {
      formParam += '[' + namespace.shift() + ']';
    }
    return {
      param : formParam,
      msg   : msg,
      value : value
    };
  }
}));

// Connect Flash
app.use(flash());

// Global Vars
app.use(function (req, res, next) {
  res.locals.success_msg = req.flash('success_msg');
  res.locals.error_msg = req.flash('error_msg');
  res.locals.error = req.flash('error');
  res.locals.user = req.user || null;
  next();
});

app.use('/', root);
app.use('/users', users);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

/* --- error handlers ---- */

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});




/* --------------------------------- my services --------------------------------- */

//var util = require('util');
var format = require('util').format;
//var assert = require('assert');
var EventEmitter = require('events').EventEmitter;
var appEmitter = new EventEmitter();



/**** Network - socket.io ****/

var http_server = require('http').Server(app);
var io = require('socket.io')(http_server);
io.on('connect', function (socket) {
  socket.emit('connected', { hello: 'to broswer' });
  socket.on('broswer greeting app', function (data) {
    console.log("socket.io - browser greeting app: %s", JSON.stringify(data));
  });
  socket.on('broswer processing reading', function (data) {
    console.log("socket.io - broswer processing on new reading: %s", JSON.stringify(data));
  });
});
io.on('disconnect', function (socket) {
  console.log("socket.io - a broswer disconnected.");
});
io.on('reconnect', function (socket) {
  console.log("socket.io - a broswer reconnected.");
});




/**** Network - UDP ****/

var UDP_listening_port = 16604;
var UDP_server = function(UDP_listening_port){
    //var self = this;
    var dgram = require('dgram');
    var udp_socket = dgram.createSocket('udp4');
    
    udp_socket.bind( UDP_listening_port, function() {
      console.log("UDP_server - socket binds to: %s", UDP_listening_port);
    });

    udp_socket.on("error", function (err) {
      console.log("UDP_server - socket on error: %s", err.stack);
      udp_socket.close();
    });

    udp_socket.on("listening", function () {
      var address = udp_socket.address();
      console.log("UDP_server - socket listening on %s:%s", address.address, address.port);
    });
      
    udp_socket.on("message", function (msg, rinfo) {
      console.log("UDP_server - incoming UDP from %s:%s: %s", rinfo.address, rinfo.port, msg);
      if (msg.indexOf("Punttoo") >= 0) {
          console.log("UDP_server.js - incoming_UDP_is_Punttoo");
          msg = msg.toString('ascii');
          appEmitter.emit('incoming_UDP_is_Punttoo', msg); 
      } 
      else {
          console.log("UDP_server: incoming UDP isn't Punttoo: %s",msg);
      }

    // this.on('newListener', function(listener) {
    //   console.log('UDP_server - new listener: ' + listener);
    // });
    // this.on('removeListener', function(listener) {
    //   console.log('UDP_server - remove listener: ' + listener);
    // });

    });
};


/**** GEO - reverse-geo */

var request = require('request');
var geo_server_ip = "64.71.155.103";
var geo_server_port = 16721;
var rev_geo_Address;

var reversegeo = function (reading) {
  rev_geo_Address = null;
  if (reading.ACQUSITION) {
  var latitude = reading.LATITUDE, longitude = reading.LONGITUDE;
  var rev_geo_uri = format('http://%s:%d/soniyatech/GisServlet?action=rgeocode&lat=%d&lon=%d',geo_server_ip,geo_server_port,latitude,longitude);
  request.get(rev_geo_uri, function (error, response, body) {
    if (!error && response.statusCode == 200) {
      rev_geo_Address = body.toString('ascii');
    }
    console.log("reversegeo.js: address is %s", rev_geo_Address);
    });
  }
  return rev_geo_Address;
};


/**** Device - Punttoo */

var move_decimal = require('move-decimal-point');
var distance_unit = "imperial";

var Punttoo = function () {
  //var self = this;
  appEmitter.on('incoming_UDP_is_Punttoo', function(signal) {
    var intermediate;
    var imei  = signal.slice(8,23);
    var model="Punttoo";
    if (signal.indexOf("ACK") >= 0) {
      intermediate = "Punttoo,012813006342879,ACK,item,status";
      var item,status;
      intermediate = signal.slice(28);
      item = intermediate.slice(0,intermediate.indexOf(","));
      status = intermediate.slice(item.length+1);
      var today = new Date();
      var ack = {
            MODEL:   model,
            IMEI:    imei,
            ACK:     "ACK",
            ITEM:    item,
            STATUS:  status,
            THE_UTC_TIMESTAMP:  today.toISOString()};
      console.log("Punttoo - incoming_UDP_Punttoo_ack_parsed: %s,%s,%s,%s,%s",
            ack.MODEL,
            ack.IMEI,
            ack.ACK,
            ack.ITEM,
            ack.STATUS,
            ack.THE_UTC_TIMESTAMP);
      appEmitter.emit('incoming_UDP_Punttoo_ack_parsed', ack);
    }
    else {
      intermediate = "Punttoo,012813006342879,$C,7,WCDMA,310,410,0xDE76,5872298,$P,2,70,$GPRMC,053436.000,A,3737.9322,N,12194.1046,W,1.01,186.75,011116,,,A*72"; 
      var c_csq,
          c_mode,
          c_country,
          c_operator,
          c_station,
          c_cell,
          p_status,
          p_level,
          utc_time,
          acquisition,
          latitude,
          longitude,
          knot,
          course,
          utc_date,
          theAddress,
          theTime;
      
      var C = signal.indexOf("$C,");
      if (C >= 0) {
        intermediate = signal.slice(C+3);
        c_csq = intermediate.slice(0,intermediate.indexOf(","));
        intermediate = signal.slice(27+c_csq.length+1);
        c_mode = intermediate.slice(0,intermediate.indexOf(","));
        intermediate = intermediate.slice(c_mode.length+1);
        c_country = intermediate.slice(0,intermediate.indexOf(","));
        intermediate = intermediate.slice(c_country.length+1);
        c_operator = intermediate.slice(0,intermediate.indexOf(","));
        intermediate = intermediate.slice(c_operator.length+1);
        c_station = intermediate.slice(0,intermediate.indexOf(","));
        intermediate = intermediate.slice(c_station.length+1);
        c_cell = intermediate.slice(0,intermediate.indexOf(","));
      }
      
      var P = signal.indexOf("$P,");
      if (P >= 0) {
        intermediate = signal.slice(P+3);
        p_status = intermediate.slice(0,intermediate.indexOf(","));
        intermediate = intermediate.slice(intermediate.indexOf(",")+1);
        p_level = intermediate.slice(0,intermediate.indexOf(","));
      }
      
      var GPRMC = signal.indexOf("$GPRMC,");
      if (GPRMC >= 0) {
        var A = signal.indexOf(",A,");
        var V = signal.indexOf(",V,");
        var N = signal.indexOf(",N,");
        var S = signal.indexOf(",S,");
        var W = signal.indexOf(",W,");
        var E = signal.indexOf(",E,");
        var end = signal.indexOf(",,,");
        if ((A >= 0) && (V < 0)) {
          acquisition = true;
          intermediate = signal.slice(GPRMC+7);
          utc_time = intermediate.slice(0,intermediate.indexOf("."));
          if ((N >= 0) && (S < 0) && (W >= 0) && (E < 0)) {
            latitude = move_decimal((signal.slice(A+3,N)),-2);
            longitude = -(move_decimal((signal.slice(N+3,W)),-2));
          }
          else {
            if ((S >= 0) && (N < 0) && (W >= 0) && (E < 0)) {
              latitude = -(move_decimal((signal.slice(A+3,S)),-2));
              longitude = -(move_decimal((signal.slice(S+3,W)),-2));
            }
            else {
              if ((N >= 0) && (S < 0) && (E >= 0) && (W < 0)) {
                latitude = move_decimal((signal.slice(A+3,N)),-2);
                longitude = move_decimal((signal.slice(N+3,E)),-2);
              }
              else {
                if ((S >= 0) && (N < 0) && (E >= 0) && (W < 0)) {
                  latitude = -(move_decimal((signal.slice(A+3,S)),-2));
                  longitude = move_decimal((signal.slice(S+3,E)),-2);
                }
              }
            }
          }
          if ( W >= 0) {intermediate = signal.slice(W+3);} 
          if ( E >= 0) {intermediate = signal.slice(E+3);} 
          knot = intermediate.slice(0,intermediate.indexOf(","));
          if (distance_unit.includes("metric")) {knot = 1.15*knot;}
          intermediate = intermediate.slice(knot.length+1);
          course = intermediate.slice(0,intermediate.indexOf(","));
          utc_date = intermediate.slice(course.length+1,course.length+7);
          
          //reverse geo
          // var rev_geo_uri = format('http://%s:%d/soniyatech/GisServlet?action=rgeocode&lat=%d&lon=%d',geo_server_ip,geo_server_port,latitude,longitude);
          // request.get(rev_geo_uri, function (error, response, body) {
          //   if (!error && response.statusCode == 200) {
          //     theAddress = body.toString('ascii');
          //   }
          //   console.log("reversegeo.js: address is %s", theAddress);
          //   });
          
          //make my timestamp
          theTime = 20+utc_date.slice(4)+utc_date.slice(2,4)+utc_date.slice(0,2)+utc_time; 
         }
        else {
          //console.log("It was a seeking signal.");
          acquisition = false;
       }
      }
      var reading = {
        MODEL:      model,
        IMEI:       imei,
        C_CSQ:      c_csq,
        C_MODE:     c_mode,
        C_COUNTRY:  c_country,
        C_OPERATOR: c_operator,
        C_STATION:  c_station,
        C_CELL:     c_cell,
        P_STATUS:   p_status,
        P_LEVEL:    p_level,
        UTC_TIME:   utc_time,
        ACQUSITION: acquisition,
        LATITUDE:   latitude,
        LONGITUDE:  longitude,
        KNOT:       knot,
        COURSE:     course,
        UTC_DATE:   utc_date,
        THE_ADDRESS:        theAddress,
        THE_UTC_TIMESTAMP:  theTime};
      console.log("Punttoo - incoming_UDP_Punttoo_reading_parsed: %s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s",
                                              reading.MODEL,
                                              reading.IMEI,
                                              reading.C_CSQ,
                                              reading.C_MODE,
                                              reading.C_COUNTRY,
                                              reading.C_OPERATOR,
                                              reading.C_STATION,
                                              reading.C_CELL,
                                              reading.P_STATUS,
                                              reading.P_LEVEL,
                                              reading.UTC_TIME,
                                              reading.ACQUSITION,
                                              reading.LATITUDE,
                                              reading.LONGITUDE,
                                              reading.KNOT,
                                              reading.COURSE,
                                              reading.UTC_DATE,
                                              reading.THE_ADDRESS,
                                              reading.THE_UTC_TIMESTAMP);
      appEmitter.emit('incoming_UDP_Punttoo_reading_parsed', reading);
    }
  });
};



/**** Database - MongoDB ****/

var mongodb;
//var MongoClient = require('mongodb').MongoClient;
var mongoose = require('mongoose');
mongoose.Promise = global.Promise;
/* for connecting to standlaone MongoDB server
var mongo_server = '162.235.120.179';
var mongo_server_port = 27017;
var mongo_user = encodeURIComponent('united');
var mongo_password = encodeURIComponent('j3byrcc');
var mongo_authSource = 'united';
var mongo_authMechanism = 'DEFAULT';
var mongo_uri = format('mongodb://%s:%s@%s:%d/%s?authMechanism=%s', mongo_user, mongo_password, mongo_server, mongo_server_port, mongo_authSource, mongo_authMechanism);
*/
/* for connecting to MongoDB Atlas*/
var mongo_uri = 'mongodb+srv://united:j3byrcc@cluster0-ng5j6.azure.mongodb.net/united?retryWrites=true';

/* establish MongoDB connection */
mongoose.connect(mongo_uri,{useNewUrlParser: true, useCreateIndex: true});
mongodb = mongoose.connection;
mongodb.on('error', console.error.bind(console, 'mongodb connection error:'));
mongodb.once('open', function() {
  console.log("mongoose - MongoDB connected successfully."); // we're connected!
});

// load mongoose models
var Signal_reading = require('./models/signal.js');
var Signal_ack = require('./models/signal.js');



/* ---------------------------- begin flow --------------------------- */

var UDP_server = new UDP_server(UDP_listening_port);
var Punttoo = new Punttoo();

appEmitter.on("incoming_UDP_Punttoo_reading_parsed", function(reading) {
  io.emit('new reading to broswer', reading); //socket.io emits new reading (to layout.pug to update)
  Signal_reading.mongo_saveOneReading(reading); //save this reading to MongoDB
  var rgeo_address = reversegeo(reading);
  
});

appEmitter.on("incoming_UDP_Punttoo_ack_parsed", function(ack) {
  io.emit('new ack to broswer', ack); //socket.io emits new ack (to layout.pug to update)
  Signal_ack.mongo_saveOneAck(ack); //save this ack to MongoDB
});





/**---------------------------- end  flow --------------------------- */

module.exports = {app:          app,
                  http_server:  http_server,
                  io:           io};