/* 
* Project:          the new unitedtracking.com
* Description:      using Nodejs/Express
* Author:           Wayne
* Creation Date:    2019-04-09
* Change Log:       2019-04-15  initial base 4170CTO
*   
*/

// configurations
var http_port = 3000;

// definations
var express = require('express');
var app = express();
app.use(express.json());
var axios = require('axios');

// Express routing
app.get('/', function(req,res) {
    console.log("Server recieved a GET@/");
    console.log(req.body);
});

// 
app.post('/device', function(req,res) {
    console.log("Server recieved a POST@/device:\r\n");
    console.log(req.body);

    var ack_obj = {
        ack: true
    };
    res.send(ack_obj);
});

app.put('/device', function(req,res) {
    console.log("Server recieved a PUT@/device:\r\n");
    console.log(req.body);

    var ack_obj = {
        ack: true
    }
    res.send(ack_obj);
});

app.delete('/', function(req,res) {
    console.log("Server recieved a DELETE@/");
    console.log(req.body);
});

// start a http server
app.listen(http_port, function () {
    console.log("Listening on port %s", http_port);
});