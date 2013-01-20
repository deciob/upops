define [
  'backbone'
  'laconic'
], (Backbone, laconic) ->
  'use strict'

  class MapLegend extends Backbone.View

    el: "#map_legend"

    initialize: (options) ->
      @message = $.el.h4 {'class' : 'title'}, 'This is the map legend'
      
    render: ->
      @$el.html @message