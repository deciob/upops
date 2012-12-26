define [
  'backbone'
  'text!templates/top.html'
], (Backbone, template) ->
  'use strict'


  Top = Backbone.View.extend(

    el: "#top"

    initialize: (options) ->
      @setElement $(@el)
  
    render: ->
      template = _.template template
      @$el.html template
  
  )