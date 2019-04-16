/* Product: LBS tracking server
* Author:   Wayne
* Date:     2019-04-09
* Change log: 
*/

// configurations
var http_port = 3000;

// definations
var express = require('express');
var app = express();
app.use(express.json());

// routing
app.get('/', function(req,res) {
    console.log("Server recieved a GET@/");
    res.send('Server responding to your GET/ \r\n');
});

app.post('/', function(req,res) {
    console.log("Server recieved a POST@/, request body: \r\n");
    console.log(req.body);
    console.log(req.hostname);
    console.log(req.ip);

    var res_obj = {
        device_SN: "B40KAB841VCXKEY",
        ack: true
    };
    
    res.send(res_obj);
});

app.put('/', function(req,res) {
    console.log("Server recieved a PUT@/");
    res.send('Server responding to your PUT/ \r\n');
});

app.delete('/', function(req,res) {
    console.log("Server recieved a DELETE@/");
    res.send('Server responding to your DELETE/ \r\n');
});

// start http server
app.listen(PORT, function () {
    console.log("Listening on port %s", http_port);
});