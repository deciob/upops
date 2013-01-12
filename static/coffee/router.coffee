define [
  'backbone'
  'libs/view_manager'
  'libs/geojson_miso_parser'
  'views/main_view'
  'models/country_model'
  'libs/utils'
], (Backbone, ViewManager, GeoJsonParser, MainView, CountryModel, utils) ->
  'use strict'


  Backbone.Router.extend(

    routes:
      #"": "world"
      "country(/:code)(/:year)/": "country"
      #"country/:code/": "country"

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
      #@dispatcher = _.clone(Backbone.Events)
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
        #console.log "onDataLoad", @, wr, cd
        options = 
          #dispatcher: @dispatcher
          model: @country_model
          country_list: utils.getCountryList(cd)
          world_geo: wg
          cities_dataset: cd
        @main_view = new MainView(options)
        ## Lets tell the world the data is here!
        ##@trigger 'onDataLoad', cd, wg
  
    world: (year) ->
      year = year or 1955
      @deferred.done =>
        @main_view.render("world", year)
        #if not @world_map.rendered
        #  @world_map.render [cd, wg]
        #@world_map.zoomToCountry()

    country: (code, year) ->
      code = code or "world"
      year = year or 1955
      @country_model.set {country: code, year: year}
      @deferred.done =>
        #console.log "router:country", code, @world_map.rendered
        @main_view.render()
  
  )