define [
  'backbone'
  'text!templates/world_map.html'
], (Backbone, template) ->
  'use strict'


  WorldMap = Backbone.View.extend(

    el: "#world_map"

    initialize: (options) ->
      options = options or {}
      @defaultMessage = "World Map (main visualisation)"
      @message = options.message or @defaultMessage
      @setElement $(@el)
  
    render: ->
      template = _.template template, {message: @message}
      @$el.html template
  
    #update: (message) ->
    #  if typeof message isnt "undefined"
    #    @message = message
    #  else
    #    @message = @defaultMessage
    #  @render()
  )