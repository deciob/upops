define [
  'backbone'
  'libs/utils'
  'libs/mapper'
  'text!templates/map_viz.html'
], (Backbone, utils, mapper, template) ->
  'use strict'

  # The router updates the Country Model. 
  # The Main View just initializes the MapViz View, but does not call render 
  # on it.
  # The MapViz View calls the render method only once, on initialization.
  # The render method renders the map and sets the appropriate callbacks on
  # Country Model change to update the map accordingly.

  class MapViz extends Backbone.View

    el: "#map_viz"

    initialize: (options) ->
      @model = options.model
      @world_geo = options.world_geo
      @cities_dataset = options.cities_dataset
      @map = mapper()
      @map.el @el
      @map.data {base: @world_geo, overlay: @cities_dataset}
      @map.width @$el.innerWidth()
      @map.height utils.getMiddleHeight()
      @render()
        
    # Called only once!
    # After this the map will be updated using d3 data-joins.
    render: ->
      # Render the map.
      @map @model.get("country")
      # Set the callbacks.
      @model.on 'change:country', (model, country) =>
        # The order here is relevant!
        # Zoom to country also updates the overlay style. If the overlay is 
        # updated after the zoomToCountry, then it will be not re-styled in
        # accordance to the new zoom level.
        # TODO: make the order irrelevant?
        @updateChartCountry country
        @zoomToCountry country
      @model.on 'change:year', (model, year) =>
        @updateChartYear year

    zoomToCountry: (country) ->
      #console.log "MapViz:zoomToCountry", @model.get "country"
      @map.zoomToCountry country

    updateChartCountry: (country) ->
      @map.renderOverlay country

    updateChartYear: (year) ->
      @map.updateOverlay year