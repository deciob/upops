var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'views/map_title', 'views/map_viz', 'views/map_legend'], function(Backbone, MapTitle, MapViz, MapLegend) {
  'use strict';

  var MapView;
  return MapView = (function(_super) {

    __extends(MapView, _super);

    function MapView() {
      return MapView.__super__.constructor.apply(this, arguments);
    }

    MapView.prototype.initialize = function(options) {
      this.views = {};
      this.views.map_viz = new MapViz(options);
      this.views.map_title = new MapTitle(options);
      this.views.map_legend = new MapLegend(options);
      return this.render();
    };

    MapView.prototype.render = function() {
      return this.views.map_legend.render();
    };

    return MapView;

  })(Backbone.View);
});
