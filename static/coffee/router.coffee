define [
  'backbone'
  'libs/view_manager'
  'libs/geojson_miso_parser'
  'views/world_map'
  'views/world_info'
  'views/country_map'
  'views/country_info'
  'views/top'
  'views/timeline'
], (Backbone, ViewManager, GeoJsonParser, WorldMap, WorldInfo, CountryMap, CountryViz, Top, Timeline) ->
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
        "iso_a2",
        "Urban_Aggl"]

    # For this application we have 2 datasets.
    # `world` is just some geojson data for d3 to create a world base map.
    # `dataset` contains a population timeseries for major world cities.
    initialize: ->
      @dispatcher = _.clone(Backbone.Events)
      options = {dispatcher: @dispatcher}
      @world_map = new WorldMap({dispatcher: @dispatcher})
      #@country_map = new CountryMap({dispatcher: @dispatcher})
      #@mapViewManager = new Backbone.ViewManager(options, @world_map, @country_map)
      
      # data initialization. 
      dataset = new Miso.Dataset(
        options: @options
        url: "static/data/urban_agglomerations.geojson"
        parser : GeoJsonParser
      )
      world = $.ajax "static/data/topo_world.json"
      @deferred = _.when(dataset.fetch(), world)
      @deferred.done (ds, wr) =>
        #console.log "onDataLoad", @, arguments, 'kk', a, b
        # The top view for now stays the same, independently from the routing.
        top = new Top({dispatcher: @dispatcher})
        top.render(ds)
        timeline = new Timeline({dispatcher: @dispatcher})
        timeline.render(arguments[0])
        world_info = new WorldInfo({dispatcher: @dispatcher, default_year: 1950})
        world_info.render()
        # Lets tell the world the data is here!
        @trigger 'onDataLoad', ds, wr
  
    world: ->
      @deferred.done (ds, wr) =>
        if not @world_map.rendered
          @world_map.render [ds, wr]
        @world_map.zoomToCountry()
        #console.log 'world:'
        #world_map = new WorldMap({dispatcher: @dispatcher})
        #@world_map.trigger 'activate', @world_map, arguments
        #@mapViewManager.activate @world_map, [ds, wr]
        #world_info = new WorldInfo({dispatcher: @dispatcher, default_year: 1950})
        #world_info.render()

    country: (code) ->
      @deferred.done (ds, wr) =>
        #console.log "router:country", code, @world_map.rendered

        if not @world_map.rendered
          @world_map.render [ds, wr, code]
        else
          @world_map.zoomToCountry code
        #@dispatcher.trigger 'onNavigation:country', code
        #console.log 'country:', code
        #@country_map .trigger 'activate', @country_map, code#arguments
        #@mapViewManager.activate @country_map, [ds, wr, code]
        #@dispatcher.trigger 'onNavigation:country', code
  
    
  )