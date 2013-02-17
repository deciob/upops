
define(['backbone', 'libs/view_manager', 'libs/geojson_miso_parser', 'views/app_title', 'views/country_picker', 'views/main_view', 'models/country_model', 'libs/utils'], function(Backbone, ViewManager, GeoJsonParser, AppTitle, CountryPicker, MainView, CountryModel, utils) {
  'use strict';
  return Backbone.Router.extend({
    routes: {
      "": "country",
      "country(/:code)(/:year)/": "country"
    },
    options: {
      columns: ["geometry", "POP1950", "POP1955", "POP1960", "POP1965", "POP1970", "POP1975", "POP1980", "POP1985", "POP1990", "POP1995", "POP2000", "POP2005", "POP2010", "POP2015", "POP2020", "POP2025", "Country", "iso_a2", "Urban_Aggl"]
    },
    initialize: function() {
      var cities_dataset, world_geo,
        _this = this;
      world_geo = $.ajax("static/data/topo_world.json");
      cities_dataset = new Miso.Dataset({
        options: this.options,
        url: "static/data/urban_agglomerations.geojson",
        parser: GeoJsonParser
      });
      this.country_model = new CountryModel();
      this.deferred = _.when(world_geo, cities_dataset.fetch());
      return this.deferred.done(function(wg, cd) {
        var comparator, options;
        comparator = function(a, b) {
          return b.POP1950 - a.POP1950;
        };
        cd.sort(comparator);
        options = {
          model: _this.country_model,
          country_list: utils.getCountryList(cd),
          world_geo: wg[0],
          cities_dataset: cd
        };
        return _this.main_view = new MainView(options);
      });
    },
    country: function(code, year) {
      var _this = this;
      code = code || "world";
      year = year || 1955;
      return this.deferred.done(function() {
        _this.country_model.set("country", code);
        return _this.country_model.set("year", year);
      });
    }
  });
});
