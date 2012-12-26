define [
  'backbone'
  'text!templates/country_map.html'
], (Backbone, template) ->
  'use strict'


  CountryMap = Backbone.View.extend(

    el: "#country_map"

    initialize: (options) ->
      @setElement $(@el)
  
    render: ->
      template = _.template template
      @$el.html template
  
  )