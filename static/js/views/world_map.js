// Generated by CoffeeScript 1.4.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'libs/utils', 'libs/mapper', 'views/base', 'text!templates/world_map.html'], function(Backbone, utils, mapper, Base, template) {
  'use strict';

  var WorldMap;
  return WorldMap = (function(_super) {

    __extends(WorldMap, _super);

    function WorldMap() {
      return WorldMap.__super__.constructor.apply(this, arguments);
    }

    WorldMap.prototype.el = "#world_map";

    WorldMap.prototype.initialize = function(options) {
      WorldMap.__super__.initialize.call(this, options);
      this.defaultMessage = "World Map (main visualisation)";
      this.message = this.options.message || this.defaultMessage;
      return this.rendered = false;
    };

    WorldMap.prototype.render = function(args) {
      var country, dimensions, ds, height, width, wr;
      this.gsubscribe('onSlide', this.updateChart, this);
      this.gsubscribe('onNavigation:country', this.zoomToCountry, this);
      wr = args[1][0];
      ds = args[0];
      country = args[2];
      dimensions = this._getViewDimensions();
      width = dimensions.width;
      height = dimensions.height;
      this.map = mapper();
      this.map.el(this.el);
      this.map.data({
        base: wr,
        overlay: ds
      });
      this.map.width(width);
      this.map.height(height);
      this.map(country);
      return this.rendered = true;
    };

    WorldMap.prototype.updateChart = function(year) {
      return this.map.updateOverlay(year);
    };

    WorldMap.prototype.zoomToCountry = function(country) {
      return this.map.zoomToCountry(country);
    };

    return WorldMap;

  })(Base);
});
