define [
  'backbone'
  'laconic'
], (Backbone, laconic) ->
  'use strict'

  class MapTitle extends Backbone.View

    el: "#map_title"

    initialize: (options) ->
      @model = options.model
      @model.on 'change', (model, year) => @render()
      
    render: ->
      year = @model.get 'year'
      country = @model.get 'country'
      title = "#{country} - #{year}"
      @$el.html $.el.h4 {'class' : 'title'}, title