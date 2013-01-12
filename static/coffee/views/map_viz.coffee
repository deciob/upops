define [
  'backbone'
  'libs/utils'
  'libs/mapper'
  'text!templates/map_viz.html'
], (Backbone, utils, mapper, template) ->
  'use strict'


  class MapViz extends Backbone.View

    el: "#map_viz"

    initialize: (options) ->
      # Storing the rendered state, because I am only rendering this once,
      # after this I will be using d3 data-joins to update the visualization.
      @rendered = no
      @model = options.model
      @world_geo = options.world_geo
      @cities_dataset = options.cities_dataset
      #@model.on 'change:country', (model, country) =>
      #  @zoomToCountry country
      #@model.on 'change:year', (model, year) =>
      #  @updateChart year
        
    render: ->
      if not @rendered
        @map = mapper()
        @map.el @el
        @map.data {base: @world_geo, overlay: @cities_dataset}
        @map.width @$el.innerWidth()
        @map.height utils.getMiddleHeight()
        @map @model.get("country")
        @rendered = yes
      else
        country = @model.get "country"
        year = @model.get "year"
        if country
          @zoomToCountry country
        if year
          @updateChart year

    updateChart: (year) ->
      # The ? is here because 'change:country' is fired before 'change'.
      @map.updateOverlay year

    zoomToCountry: (country) ->
      console.log "MapViz:zoomToCountry", @model.get "country"
      @map?.zoomToCountry country

