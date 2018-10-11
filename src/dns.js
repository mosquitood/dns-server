var dns    = require('native-dns');
var redis  = require("redis");
var client = redis.createClient();
var server = dns.createServer();
var i = 0;

server.on('request', function (request, response) {
  var domain = request.question[0].name;
  if (domain.endsWith(process.env['NS'])) {
    client.rpush(domain, request.address.address)
    response.answer.push(dns.A({
      name: domain,
      address: process.env['IP'],
      ttl: 600
    }));
    response.send();
  } else {
    response.answer.push(dns.CNAME({
      name: domain,
      data: 'ghs.googlehosted.com.',
      ttl: 30
    }));
    response.send();
  }
});

server.on('error', function (err, buff, req, res) {
  console.log(err.stack);
});
server.serve(53);
