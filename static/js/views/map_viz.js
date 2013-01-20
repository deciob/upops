// Generated by CoffeeScript 1.4.0
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'libs/utils', 'libs/mapper', 'libs/mediator'], function(Backbone, utils, mapper, mediator) {
  'use strict';

  var MapViz;
  return MapViz = (function(_super) {

    __extends(MapViz, _super);

    function MapViz() {
      this.updateYear = __bind(this.updateYear, this);
      return MapViz.__super__.constructor.apply(this, arguments);
    }

    MapViz.prototype.mediator = mediator;

    MapViz.prototype.el = "#map_viz";

    MapViz.prototype.initialize = function(options) {
      debugger;
      var dms;
      this.model = options.model;
      this.world_geo = options.world_geo;
      this.cities_dataset = options.cities_dataset;
      this.map = mapper();
      this.map.el(this.el);
      this.map.data({
        base: this.world_geo,
        overlay: this.cities_dataset
      });
      dms = this.getMapVizDims();
      this.$el.height(dms.h);
      this.map.width(dms.w);
      this.map.height(dms.h);
      return this.render();
    };

    MapViz.prototype.render = function() {
      var _this = this;
      this.map(this.model.get("country"), this.model.get("year"));
      this.model.on('change:country', function(model, country) {
        _this.updateOvervaly(country, model.get("year"));
        return _this.zoomToCountry(country);
      });
      this.model.on('change:year', function(model, year) {
        return _this.updateYear(year);
      });
      return this.mediator.on("onSlide", this.updateYear);
    };

    MapViz.prototype.getMapVizDims = function() {
      var current_wh_ratio, h, map_wh_ratio, other, top, w;
      top = $("#top").height();
      other = 160;
      h = $(document).height() - top - other;
      w = this.$el.width();
      map_wh_ratio = 960 / 500;
      current_wh_ratio = w / h;
      if (current_wh_ratio > map_wh_ratio) {
        return {
          h: h,
          w: h * map_wh_ratio
        };
      } else {
        return {
          w: w,
          h: w / map_wh_ratio
        };
      }
    };

    MapViz.prototype.zoomToCountry = function(country) {
      return this.map.zoomToCountry(country);
    };

    MapViz.prototype.updateOvervaly = function(country, year) {
      return this.map.renderOverlay(country, year);
    };

    MapViz.prototype.updateYear = function(year) {
      return this.map.updateYear(year);
    };

    return MapViz;

  })(Backbone.View);
});
