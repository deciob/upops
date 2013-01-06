define [
  'backbone'
  'libs/utils'
  'libs/mapper'
  'views/base'
  'text!templates/world_map.html'
], (Backbone, utils, mapper, Base, template) ->
  'use strict'


  class WorldMap extends Base

    el: "#world_map"

    initialize: (options) ->
      super options
      #@setElement $(@el)
      @defaultMessage = "World Map (main visualisation)"
      @message = @options.message or @defaultMessage
      #@dispatcher.on 'onSlide', @updateChart, @
      #@gsubscribe 'onSlide', @updateChart, @
      @rendered = no

    render: (args) ->
      #console.log 'WorldMap:render',  args
      @gsubscribe 'onSlide', @updateChart, @
      #@gsubscribe 'onNavigation:country', @zoomToCountry, @
      wr = args[1][0] # World topoJSON countries
      ds = args[0] # Cities dataset
      country = args[2]
      dimensions = @_getViewDimensions()
      width = dimensions.width
      height = dimensions.height 
      @map = mapper()
      @map.el @el
      @map.data {base: wr, overlay: ds}
      @map.width width
      @map.height height
      # draw the map
      @map country
      @rendered = yes

    updateChart: (year) ->
      @map.updateOverlay year

    zoomToCountry: (country) ->
      #console.log 'country, ', country
      @map.zoomToCountry(country)

