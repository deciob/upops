define [
  'backbone'
], (Backbone) ->
  'use strict'

  # The `ViewManager` manages a list of Views where only one is, 
  # at all times, active and visible.
  #
  # Usage:
  # `world_map = new WorldMap()`
  # `country_map = new CountryMap()`
  # `mapViewManager = new Backbone.ViewManager options, world_map, country_map`
  # `mapViewManager.activate world_map, arguments`

  class Backbone.ViewManager
    
    constructor: (options, args...) ->
      #console.log 'Backbone.ViewManager:constructor', options, args
      @dispatcher = options.dispatcher
      @views = []
      @add(args)

    add: (views) ->
      #console.log 'Backbone.ViewManager:add', views
      @addOne(view) for view in views

    addOne: (view) ->
      #console.log 'Backbone.ViewManager:addOne', view.el
      $(view.el).hide()
      @views.push(view)

    activate: (view, args) =>
      #console.log 'Backbone.ViewManager:activate', view, @activeView
      if @activeView
        @activeView.dispose()
      $(view.el).show()
      view.render args
      @activeView = view
