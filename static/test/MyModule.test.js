define(["chai", "backbone", "router"], function(chai, Backbone, Router) {

  var should = chai.should();

  describe('Router', function () {

    describe('#initialize()', function () {

      it('should be a stinkin object', function () {
        var yippee = {},
        mainRoute;
        mainRoute = new Router();
        Backbone.history.start();
        //console.log(Backbone);
        yippee.should.be.an('object');
      });

    });

  });

});