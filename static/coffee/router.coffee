define [
  'backbone'
  'libs/view_manager'
  'libs/geojson_miso_parser'
  'views/app_title'
  'views/country_picker'
  'views/main_view'
  'models/country_model'
  'libs/utils'
], (Backbone, ViewManager, GeoJsonParser, AppTitle, CountryPicker, MainView, CountryModel, utils) ->
  'use strict'


  Backbone.Router.extend

    routes:
      "": "country"
      "country(/:code)(/:year)/": "country"

    

    options:
      # Used within the custom Miso parser: GeoJsonParser
      columns: [
        "geometry",
        "POP1950", 
        "POP1955",
        "POP1960", 
        "POP1965", 
        "POP1970", 
        "POP1975", 
        "POP1980", 
        "POP1985", 
        "POP1990", 
        "POP1995", 
        "POP2000", 
        "POP2005", 
        "POP2010", 
        "POP2015", 
        "POP2020", 
        "POP2025", 
        "Country",
        "iso_a2",
        "Urban_Aggl"]
      

    # For this application we have 2 datasets.
    # `world_geo` is geojson data only used in d3 to create a world base map. 
    # `dataset` contains a population time-series for major world cities.
    initialize: ->
      @dispatcher = _.clone(Backbone.Events)
      # data initialization.
      world_geo = $.ajax "static/data/topo_world.json"
      # `cities_dataset` is the main data repository for the application.
      cities_dataset = new Miso.Dataset(
        options: @options
        url: "static/data/urban_agglomerations.geojson"
        parser : GeoJsonParser
      )
      @country_model = new CountryModel()
      @deferred = _.when(world_geo, cities_dataset.fetch())
      @deferred.done (wg, cd) =>
        #console.log "onDataLoad", wg, cd.toJSON()
        # Sorting dataset, from higher to lower city population.
        comparator = (a, b) ->
          b.POP1950 - a.POP1950
        cd.sort(comparator)
        options = 
          model: @country_model
          country_list: utils.getCountryList(cd)
          world_geo: wg[0]
          cities_dataset: cd
          dispatcher: @dispatcher
        # These 2 views do not respond to route changes:
        app_title = new AppTitle options
        app_title.render()
        country_picker = new CountryPicker options      
        country_picker.render()
        # Grouping route views together:
        @main_view = new MainView(options)
        
    country: (code, year) ->
      code = code or "world"
      year = year or 1955
      @deferred.done =>
        #console.log year
        #@country_model.set {country: code, year: year}
        @country_model.set "country", code
        @country_model.set "year", year