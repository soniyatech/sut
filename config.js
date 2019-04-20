var UDP_server_ip = 'localhost';
var UDP_listening_port = 16604;

var web_server_ip = '192.168.1.104';
var web_server_port = 16604; 

var mqtt = require('mqtt');
var mqtt_broker_url = 'mqtt://localhost';
var mqtt_broker_port = 1883;
var mqtt_username = 'soniya';
var mqtt_password = 'j3byrcc.';
// var mqtt_username = 'Punttoo';
// var mqtt_password = 'ca03041314';
var mqtt_options = {username: mqtt_username, password: mqtt_password};

var mysql_DB_connection;
var mysql_db_server_ip = 'localhost';
var mysql_db_server_port = 3306;
var mysql_db_user_name = 'soniya';
var mysql_db_user_pwd = 'j3byrcc.';
var mysql_db_name = 'unitedtracking_db';

var MongoClient = require('mongodb').MongoClient, f = require('util').format, assert = require('assert');
var mongo_db_server_ip = 'localhost';
var mongo_db_server_port = 27017;
var mongo_user = encodeURIComponent('unitedtracking');
var mongo_password = encodeURIComponent('j3byrcc');
var mongo_authMechanism = 'DEFAULT';
var mongo_authSource = 'unitedtracking_db';
var mongo_uri = f('mongodb://%s:%s@%s:%d/%s?authMechanism=%s', mongo_user, mongo_password, mongo_db_server_ip, mongo_db_server_port, mongo_authSource, mongo_authMechanism);
