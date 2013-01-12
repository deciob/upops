define [
  'backbone'
  'models/world_info_model'
  'libs/utils'
  'text!templates/extra_info.html'
], (Backbone, WorldInfoModel, utils, template) ->
  'use strict'


  Bookmark = Backbone.View.extend(
    template: _.template()
    render: ->
      @$el.html @template(@model.toJSON())
      this
  )


  WorldInfo = Backbone.View.extend(

    el: "#extra_info"
    template: _.template template#, {model: @model.toJSON()}

    initialize: (options) ->
      @options = options or {}
      @dispatcher = options.dispatcher
      @model = new WorldInfoModel()
      @model.set({year: @options.default_year})
      @listenTo(@model, "change", @render)
      @dispatcher.on 'onSlide', @updateYear, @

    render: () ->
      @$el.html @template( {model: @model.toJSON()} )

    

    updateYear: (year) ->
      @model.set({year: year})

  )