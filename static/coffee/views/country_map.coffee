define [
  'backbone'
  'text!templates/country_map.html'
], (Backbone, template) ->
  'use strict'


  CountryMap = Backbone.View.extend(

    el: "#country_map"

    initialize: (options) ->
      @setElement $(@el)
      @template = _.template template
  
    render: (code) ->
      #console.log 'CountryMap', @$el, args
      #template = _.template template
      @$el.html @template
  
  )