define [
  'backbone'
  'laconic'
], (Backbone, laconic) ->
  'use strict'

  class AppTitle extends Backbone.View

    el: "#app_title"

    initialize: (options) ->
      @message = $.el.h3 {'class' : 'title'}, 'World Urbanization Prospects'
      
    render: ->
      @$el.html @message