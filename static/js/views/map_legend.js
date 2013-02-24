var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'laconic'], function(Backbone, laconic) {
  'use strict';

  var MapLegend;
  return MapLegend = (function(_super) {

    __extends(MapLegend, _super);

    function MapLegend() {
      return MapLegend.__super__.constructor.apply(this, arguments);
    }

    MapLegend.prototype.el = "#map_legend";

    MapLegend.prototype.initialize = function(options) {
      return this.message = $.el.h4({
        'class': 'title'
      }, 'This is the map legend');
    };

    MapLegend.prototype.render = function() {
      return this.$el.html(this.message);
    };

    return MapLegend;

  })(Backbone.View);
});
