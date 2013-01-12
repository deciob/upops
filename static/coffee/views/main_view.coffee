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
      map_viz_options = 
        model: model
        world_geo: options.world_geo
        cities_dataset: options.cities_dataset
      @views = {}
      #@views.app_title = new AppTitle options
      @views.country_picker = new CountryPicker options
      #@views.map_title = new MapTitle options
      @views.map_viz = new MapViz map_viz_options
      #@views.map_legend = new MapLegend options
      #@views.timeline = new Timeline options
      #@views.extra_info = new ExtraInfo options
      # Independent from routing, so rendering immediately and once.
      #@views.app_title.render()
      @views.country_picker.render()

    render: ->
      console.log "MainView:render"
      #@views.map_title.render country
      @views.map_viz.render()
      #@views.map_legend.render country
      #@views.timeline.render country
      #@views.extra_info.render country
