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

    initData: ->
      if not @initData.data
        @initData.data = new Miso.Dataset(
          options: @options
          url: "static/data/urban_agglomerations_1950_2010.geojson"
          parser : GeoJsonParser
        )
      @initData.data

    fetchData: (data, success) ->
      if not @fetchData.data

    routes:
      "": "index"
  
    index: ->

      top = new Top()
      top.render()

      #onSuccess = ->

      data = @initData()
      #@fetchData(data, )

      data.fetch
        success: ->
          console.log 'index:data.fetch:success', @
          world_map = new WorldMap()
          world_map.render()
          footer_viz = new FooterViz()
          footer_viz.render()


        error: ->
          #COS.app.views.title.update "Failed to load data from " + data.url
          console.log 'boooooooooooooooooooooooooooo'
  
    
  )