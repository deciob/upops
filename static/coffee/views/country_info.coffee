define [
  'backbone'
  'text!templates/country_info.html'
], (Backbone, template) ->
  'use strict'


  CountryInfo = Backbone.View.extend(

    el: "#country_info"

    initialize: (options) ->
      @setElement $(@el)
  
    render: ->
      template = _.template template
      @$el.html template
  
  )