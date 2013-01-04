define [
  'backbone'
  'views/base'
  'text!templates/country_map.html'
], (Backbone, Base, template) ->
  'use strict'


  CountryMap = Base.extend

    el: "#country_map"

    initialize: (options) ->
      @setElement $(@el)
      @template = _.template template
  
    render: (code) ->
      #console.log 'CountryMap', @$el, $(@el), code
      #template = _.template template
      $(@el).html @template
  
  