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
      @dispatcher = options.dispatcher
      @world_geo = options.world_geo
      @cities_dataset = options.cities_dataset
      @map = mapper()
      @map.el @el
      @map.data {base: @world_geo, overlay: @cities_dataset}
      dms = @getMapVizDims()
      # Setting the height on the element before map initialization,
      # because I am using the viewBox attribute on the map svg element.
      @$el.height(dms.h)
      @map.width dms.w #@$el.innerWidth()
      @map.height dms.h #utils.getMiddleHeight()
      @render()
        
    # Called only once!
    # After this the map will be updated using d3 data-joins.
    render: ->
      # Render the map.
      @map @model.get("country"), @model.get("year")
      # Set the callbacks.
      @model.on 'change:country', (model, country) =>
        # The order here is relevant!
        # Zoom to country also updates the overlay (city circles) style. 
        # If the overlay is  updated after the zoomToCountry, 
        # then it will be not re-styled in accordance to the new zoom level.
        # TODO: make the order irrelevant?
        @updateOvervaly country, model.get("year")
        @zoomToCountry country
      @model.on 'change:year', (model, year) =>
        @updateYear year
      @dispatcher.on "onSlide", @updateYear

    getMapVizDims: ->
      # TODO: this does not look nice hardcoded...
      top = $("#top").height()
      # Accounts for title and legend (temporary).
      other = 160
      h = $(document).height() - top - other
      w = @$el.width()
      map_wh_ratio = 960 / 500
      current_wh_ratio = w / h
      if current_wh_ratio > map_wh_ratio
        return {h: h, w: h * map_wh_ratio}
      else
        return {w: w, h: w / map_wh_ratio}

    zoomToCountry: (country) ->
      #console.log "MapViz:zoomToCountry", @model.get "country"
      @map.zoomToCountry country

    updateOvervaly: (country, year) ->
      @map.renderOverlay country, year

    updateYear: (year) =>
      @map.updateYear year