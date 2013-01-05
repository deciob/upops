define [
  'backbone'
  'libs/utils'
  'libs/mapper'
  'views/base'
  'text!templates/world_map.html'
], (Backbone, utils, mapper, Base, template) ->
  'use strict'


  WorldMap = Base.extend

    el: "#world_map"

    initialize: (options) ->
      @options = options or {}
      @dispatcher = options.dispatcher
      #@setElement $(@el)
      @defaultMessage = "World Map (main visualisation)"
      @message = @options.message or @defaultMessage
      @dispatcher.on 'onSlide', @updateChart, @

    render: (args) ->
      #console.log 'WorldMap:render',  args
      wr = args[1][0] # World topoJSON countries
      ds = args[0] # Cities dataset
      dimensions = @_getViewDimensions()
      width = dimensions.width
      height = dimensions.height 
      @map = mapper()
      @map.el @el
      @map.data {base: wr, overlay: ds}
      @map.width width
      @map.height height
      # draw the map
      @map()

    updateChart: (year) ->
      @map.updateOverlay year

    _getViewDimensions: ->
      height:
        utils.getMiddleHeight()
      width:
        $(@el).innerWidth()