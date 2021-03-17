
var run = require("./../map-traversal-clisp/getRoute.js");

var appRouter = function (app) {
  app.get("/", function(req, res) {
    console.log(req.query);
    var route = run(req.query.start , req.query.end, res);
  });
}

module.exports = appRouter;