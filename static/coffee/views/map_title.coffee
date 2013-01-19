define [
  'backbone'
  'laconic'
], (Backbone, laconic) ->
  'use strict'

  class MapTitle extends Backbone.View

    el: "#map_title"

    initialize: (options) ->
      @model = options.model
      @message = $.el.h3 {'class' : 'title'}, 'World Urbanization Prospects'
      @model.on 'change', (model, year) => @render()
      
    render: ->
      year = @model.get 'year'
      country = @model.get 'country'
      title = "#{country} - #{year}"
      @$el.html $.el.p {'class' : 'title'}, title