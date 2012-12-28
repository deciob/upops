define [
  'backbone'
  'libs/geojson_miso_parser'
  'views/world_map'
  'views/country_map'
  'views/country_info'
  'views/top'
  'views/footer_viz'
], (Backbone, GeoJsonParser, WorldMap, CountryMap, CountryViz, Top, FooterViz) ->
  'use strict'


  Backbone.Router.extend(

    routes:
      "": "world"
      "world/": "world"
      "country/:code/": "country"

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
        "Urban_Aggl"]

    # For this application we have 2 datasets.
    # `world` is just some geojson data for d3 to create a world base map.
    # `dataset` contains a population timeseries for major world cities.
    initialize: ->
      # The top view for now stays the same, independently from the routing.
      top = new Top()
      top.render()
      # data initialization. 
      dataset = new Miso.Dataset(
        options: @options
        url: "static/data/urban_agglomerations_1950_2010.geojson"
        parser : GeoJsonParser
      )
      world = $.ajax "static/data/world-110m.json"
      @deferred = _.when(dataset.fetch(), world)
      @deferred.done =>
        console.log "onDataLoad", @, arguments
        # Lets tell the world the data is here!
        @trigger 'onDataLoad', arguments
  
    world: ->
      @deferred.done =>
        world_map = new WorldMap()
        world_map.render(arguments)
        footer_viz = new FooterViz()
        footer_viz.render()

    country: (code) ->
      @deferred.done =>
        console.log 'country:', code
  
    
  )