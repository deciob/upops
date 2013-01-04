define [
  'backbone'
  'libs/utils'
  'text!templates/world_map.html'
], (Backbone, utils, template) ->
  'use strict'


  WorldMap = Backbone.View.extend(

    # Use instead of bind, creates a bind and stores the binding in @bindings
    bindTo: (model, ev, callback) ->
      model.bind(ev, callback, this)
      @bindings = [] unless @bindings?
      @bindings.push({ model: model, ev: ev, callback: callback })
  
    # Unbinds all the bindings in @bindings
    unbindFromAll: () ->
      if @bindings
        _.each(@bindings, (binding) ->
          binding.model.unbind(binding.ev, binding.callback))
      @bindings = []

    # Inspired from chaplin.js
    dispose: ->
      # Unbind handlers of global events
      @stopListening()
      # Unbind all model handlers
      @unbindFromAll()
      # Remove all event handlers on this module
      @off()
      # Only removing children elements because I want to keep the container. 
      # This also removes all event handlers from the children.
      $(@el).children().remove()
      # Hiding the still existing container.
      $(@el).hide()
      # Remove element references, options,
      # model/collection references and subview lists
      # TODO: this is still chaplin.js code, update accordingly!
      properties = [
        'el', '$el',
        'options', 'model', 'collection',
        'subviews', 'subviewsByName',
        '_callbacks'
      ]
      delete this[prop] for prop in properties

  )