define [
  'backbone'
  'laconic'
], (Backbone, laconic) ->
  'use strict'

  class MapTitle extends Backbone.View

    el: "#map_title"

    initialize: (options) ->
      @model = options.model
      @country_list = options.country_list
      @render()
      @listenTo @model, "change:country", (model, country) =>
        @render()
      @listenTo @model, "change:year", (model, year) =>
        @render()
      
    render: ->
      year = @model.get 'year'
      code = @model.get 'country'
      country = _.find( @country_list, (el) -> return el.code == code )
      title = "#{country.value} - #{year}"
      @$el.html $.el.h4 {'class' : 'title'}, title