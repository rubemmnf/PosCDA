var WebSocketServer = require('ws').Server;
wss = new WebSocketServer({port: 8080, path: '/testing'});
wss.on('connection', function(ws) {
    ws.on('message', function(message) {
        console.log('Msg received in server: %s ', message);
    });
    console.log('new connection');
    ws.send('Msg from server');
});