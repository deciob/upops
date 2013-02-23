define(['chai', 'jquery'], function(chai, $) {

  var should = chai.should();

  describe('MyModule', function () {
    describe('#initialize()', function () {
      it('should be a stinkin object', function () {
        var yippee = "";
        yippee.should.be.an('object');
      });
    });
  });
});