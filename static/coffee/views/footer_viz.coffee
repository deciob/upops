define [
  'backbone'
  'text!templates/footer_viz.html'
], (Backbone, template) ->
  'use strict'


  FooterViz = Backbone.View.extend(

    el: "#footer_viz"

    initialize: (options) ->
      @setElement $(@el)
  
    render: ->
      template = _.template template
      @$el.html template
  
  )