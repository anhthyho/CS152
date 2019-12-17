var net = require('net');
var eol = require('os').EOL;

var srvr = net.createServer();
var clientList = [];

var listCmd = "\\list";
var renameCmd = "\\rename";
var privateCmd = "\\private";

srvr.on('connection', function(client) {
  client.name = client.remoteAddress + ':' + client.remotePort;
  client.write('Welcome, ' + client.name + eol);
  clientList.push(client);

  client.on('data', function(data) {
    call(data, client);
  });
});

function call(data, client) {
	data += '';
	var msg = data;
		msg = msg.substring(0, msg.indexOf(eol));

	var fields = ('' + msg).split(' ');
	if (fields[0]==="\\list"){
		client.write("current users" + eol);
		for (let i of clientList)
				if(i===client){client.write(" you!!!" + eol)}
				else {
					client.write(i.name + " " + eol);
				}
				client.write(eol);
		client.write(eol);
	}
	else if (fields[0]=="\\rename"){
		if (fields.length < 1){
			client.write("no new name entered");
		}
		else{
			client.name = fields[1];
			client.write("new name: " + fields[1]);
		}
		client.write(eol);

	}
	else if (fields[0]=="\\private"){
		if (fields.length > 2){
			for (let i of clientList)
				if (i.name == fields[1])
					i.write(client.name + " DM'ed " + msg.substring(msg.indexOf(fields[2])) + eol);
		} else
			client.write("Error: No Message" + eol);
	}
	else {
		broadcast(data, client);
	}
}

function broadcast(data, client) {
  for (var i in clientList) {
    if (client !== clientList[i]) {
      clientList[i].write(client.name + " says " + data);
    }
  }
}

srvr.listen(9000);