// Generated by CoffeeScript 1.4.0

define(['backbone', 'libs/geojson_miso_parser', 'views/world_map', 'views/country_map', 'views/country_info', 'views/top', 'views/footer_viz'], function(Backbone, GeoJsonParser, WorldMap, CountryMap, CountryViz, Top, FooterViz) {
  'use strict';
  return Backbone.Router.extend({
    routes: {
      "": "world",
      "world/": "world",
      "country/:code/": "country"
    },
    options: {
      columns: ["geometry", "POP1950", "POP1955", "POP1960", "POP1965", "POP1970", "POP1975", "POP1980", "POP1985", "POP1990", "POP1995", "POP2000", "POP2005", "POP2010", "POP2015", "POP2020", "POP2025", "Country", "Urban_Aggl"]
    },
    initialize: function() {
      var dataset, top, world,
        _this = this;
      top = new Top();
      top.render();
      dataset = new Miso.Dataset({
        options: this.options,
        url: "static/data/urban_agglomerations_1950_2010.geojson",
        parser: GeoJsonParser
      });
      world = $.ajax("static/data/world-110m.json");
      this.deferred = _.when(dataset.fetch(), world);
      return this.deferred.done(function() {
        return _this.trigger('onDataLoad', arguments);
      });
    },
    world: function() {
      var _this = this;
      return this.deferred.done(function() {
        var footer_viz, world_map;
        world_map = new WorldMap();
        world_map.render(arguments);
        footer_viz = new FooterViz();
        return footer_viz.render(arguments[0]);
      });
    },
    country: function(code) {
      var _this = this;
      return this.deferred.done(function() {
        return console.log('country:', code);
      });
    }
  });
});
