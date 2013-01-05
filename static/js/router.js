// Generated by CoffeeScript 1.4.0

define(['backbone', 'libs/view_manager', 'libs/geojson_miso_parser', 'views/world_map', 'views/world_info', 'views/country_map', 'views/country_info', 'views/top', 'views/timeline'], function(Backbone, ViewManager, GeoJsonParser, WorldMap, WorldInfo, CountryMap, CountryViz, Top, Timeline) {
  'use strict';
  return Backbone.Router.extend({
    routes: {
      "": "world",
      "world/": "world",
      "country/:code/": "country"
    },
    options: {
      columns: ["geometry", "POP1950", "POP1955", "POP1960", "POP1965", "POP1970", "POP1975", "POP1980", "POP1985", "POP1990", "POP1995", "POP2000", "POP2005", "POP2010", "POP2015", "POP2020", "POP2025", "Country", "iso_a2", "Urban_Aggl"]
    },
    initialize: function() {
      var dataset, options, world,
        _this = this;
      this.dispatcher = _.clone(Backbone.Events);
      options = {
        dispatcher: this.dispatcher
      };
      this.world_map = new WorldMap({
        dispatcher: this.dispatcher
      });
      this.country_map = new CountryMap({
        dispatcher: this.dispatcher
      });
      this.mapViewManager = new Backbone.ViewManager(options, this.world_map, this.country_map);
      dataset = new Miso.Dataset({
        options: this.options,
        url: "static/data/urban_agglomerations.geojson",
        parser: GeoJsonParser
      });
      world = $.ajax("static/data/topo_world.json");
      this.deferred = _.when(dataset.fetch(), world);
      return this.deferred.done(function(ds, wr) {
        var timeline, top, world_info;
        top = new Top({
          dispatcher: _this.dispatcher
        });
        top.render(ds);
        timeline = new Timeline({
          dispatcher: _this.dispatcher
        });
        timeline.render(arguments[0]);
        world_info = new WorldInfo({
          dispatcher: _this.dispatcher,
          default_year: 1950
        });
        world_info.render();
        return _this.trigger('onDataLoad', ds, wr);
      });
    },
    world: function() {
      var _this = this;
      return this.deferred.done(function(ds, wr) {
        return _this.mapViewManager.activate(_this.world_map, [ds, wr]);
      });
    },
    country: function(code) {
      var _this = this;
      return this.deferred.done(function(ds, wr) {
        return _this.mapViewManager.activate(_this.country_map, [ds, wr, code]);
      });
    }
  });
});
