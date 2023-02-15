var http = require("http");
http.createServer(function(req,res){
    res.writeHeader(200, {"Content-Type":"text/event-stream"
                        , "Cache-Control":"no-cache"
                        , "Connection":"keep-alive"
                        , "Access-Control-Allow-Origin": "*"});
    var interval = setInterval( function() {
    res.write("data: " + randomInt(100,127) + "\n\n");
    },2000);

}).listen(9090);

console.log('SSE-Server started!');

function randomInt (low, high) {

    return Math.floor(Math.random() * (high - low) + low);
}