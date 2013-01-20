define [
  'backbone'
  'views/app_title'
  'views/country_picker'
  'views/map_view'
  'views/timeline'
  'views/extra_info'
], (Backbone, AppTitle, CountryPicker, MapView, Timeline, ExtraInfo) ->
  'use strict'


  class MainView extends Backbone.View

    initialize: (options) ->
      @views = {}
      @views.app_title = new AppTitle options
      @views.country_picker = new CountryPicker options      
      @views.map_view = new MapView options
      @views.timeline = new Timeline options
      @render()

    render: ->
      @views.app_title.render()
      @views.country_picker.render()
      



