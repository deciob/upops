var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __slice = [].slice;

define(['backbone'], function(Backbone) {
  'use strict';
  return Backbone.ViewManager = (function() {

    function ViewManager() {
      var args, options;
      options = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      this.activate = __bind(this.activate, this);

      this.dispatcher = options.dispatcher;
      this.views = [];
      this.add(args);
    }

    ViewManager.prototype.add = function(views) {
      var view, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = views.length; _i < _len; _i++) {
        view = views[_i];
        _results.push(this.addOne(view));
      }
      return _results;
    };

    ViewManager.prototype.addOne = function(view) {
      $(view.el).hide();
      return this.views.push(view);
    };

    ViewManager.prototype.activate = function(view, args) {
      if (this.activeView) {
        this.activeView.dispose();
      }
      $(view.el).show();
      view.render(args);
      return this.activeView = view;
    };

    return ViewManager;

  })();
});
