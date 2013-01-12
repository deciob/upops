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
      model = options.model
      @world_geo = options.world_geo
      @cities_dataset = options.cities_dataset
      @map = mapper
      model.on 'change:country', (model, country) =>
        @zoomToCountry country
      model.on 'change:year', (model, year) =>
        @updateChart year
        
    render: ->
      if not @rendered
        @map()
        @map.el @el
        @map.data {base: @world_geo, overlay: @cities_dataset}
        @map.width @$el.innerWidth()
        @map.height utils.getMiddleHeight()
        @rendered = yes

    updateChart: (year) ->
      @map.updateOverlay year

    zoomToCountry: ->
      @map.zoomToCountry()

