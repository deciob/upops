var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'laconic'], function(Backbone, laconic) {
  'use strict';

  var AppTitle;
  return AppTitle = (function(_super) {

    __extends(AppTitle, _super);

    function AppTitle() {
      return AppTitle.__super__.constructor.apply(this, arguments);
    }

    AppTitle.prototype.el = "#app_title";

    AppTitle.prototype.initialize = function(options) {
      return this.message = $.el.h3({
        'class': 'title'
      }, 'World Urbanization Prospects');
    };

    AppTitle.prototype.render = function() {
      return this.$el.html(this.message);
    };

    return AppTitle;

  })(Backbone.View);
});
