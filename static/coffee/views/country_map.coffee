define [
  'backbone'
  'views/base'
  'libs/mapper'
  'text!templates/country_map.html'
], (Backbone, Base, mapper, template) ->
  'use strict'


  class CountryMap extends Base

    el: "#country_map"
  
    initialize: (options) ->
      super options
      #@setElement $(@el)
      #@template = _.template template
      @defaultMessage = "Country Map (main visualisation)"
      @message = @options.message or @defaultMessage
      #@gsubscribe 'onSlide', @updateChart, @

    render: (args) ->
      #console.log 'CountryMap:render',  args
      #$(@el).html @template
      @gsubscribe 'onSlide', @updateChart, @
      wr = args[1][0] # World topoJSON countries
      ds = args[0] # Cities dataset
      country_code = args[2]
      country_ds = ds.where
        rows: (row) ->
          row["iso_a2"] == country_code
      dimensions = @_getViewDimensions()
      width = dimensions.width
      height = dimensions.height 
      @map = mapper()
      @map.el @el
      @map.country country_code
      @map.data {base: wr, overlay: country_ds}
      @map.width width
      @map.height height
      # draw the map
      @map()

    updateChart: (year) ->
      @map.updateOverlay year
  
  