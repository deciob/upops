
define(function(require) {
  return require(["jquery", "backbone", "router"], function($, Backbone, Router) {
    return $(document).ready(function() {
      var mainRoute;
      mainRoute = new Router();
      return Backbone.history.start();
    });
  });
});
