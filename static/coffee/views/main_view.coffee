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
      model = options.model
      viz_options = 
        model: model
        world_geo: options.world_geo
        cities_dataset: options.cities_dataset
      @views = {}
      @views.map_viz = new MapViz viz_options
      #@views.map_legend = new MapLegend options
      @views.timeline = new Timeline viz_options
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
