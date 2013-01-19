define [
  'backbone'
  'views/app_title'
  'views/country_picker'
  'views/map_title'
  'views/map_viz'
  'views/map_legend'
  'views/timeline'
  'views/extra_info'
], (Backbone, AppTitle, CountryPicker, MapTitle, MapViz, MapLegend, Timeline, ExtraInfo) ->
  'use strict'


  class MainView extends Backbone.View

    initialize: (options) ->
      @views = {}
      @views.map_viz = new MapViz options
      @views.map_title = new MapTitle options
      @views.timeline = new Timeline options
      #@views.extra_info = new ExtraInfo options
      # Independent from routing, so rendering immediately and once.
      #@model.on 'change', (model) =>
      #  @render()

    render: ->
      console.log "MainView:render"
      #@views.map_title.render country
      #@views.map_viz.render()
      #@views.map_legend.render country
      #@views.timeline.render country
      #@views.extra_info.render country
