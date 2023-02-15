var http = require("http");
const { stringify } = require("querystring");
var url = require("url");

function randomInt (low, high) {
  return Math.floor(Math.random() * (high - low) + low);
}

http.createServer(function(req,res){
        
    res.writeHeader(200, {"Content-Type":"text/event-stream"
                            , "Cache-Control":"no-cache"
                            , "Connection":"keep-alive"
                            , "Access-Control-Allow-Origin": "*"});
  
    var interval = setInterval( function() {
    res.write("data: " + randomInt(1,40) + "\n\n");
    },3000);
  
}).listen(8585);

console.log('Server listening on http://localhost:' + 8585);