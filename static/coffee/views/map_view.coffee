define [
  'backbone'
  'views/map_title'
  'views/map_viz'
  'views/map_legend'
], (Backbone, MapTitle, MapViz, MapLegend) ->
  'use strict'


  class MapView extends Backbone.View

    initialize: (options) ->
      @views = {}
      @views.map_viz = new MapViz options
      @views.map_title = new MapTitle options
      @views.map_legend = new MapLegend options
      @render()

    render: ->
      @views.map_legend.render()
