
define [
  'backbone'
], (Backbone) ->
  'use strict'

  class Backbone.ViewManager

    
    _.extend(@::, Backbone.Events)
    
    constructor: (options, args...) ->
      #console.log 'sss', options, args
      @dispatcher = options.dispatcher
      @views = []
      @add(args)

    add: (views) ->
      #console.log 'GGGG', views
      @addOne(view) for view in views

    addOne: (view) ->
      #console.log 'sxs', view.el
      view.on 'activate', @activate
      #$(view.el).addClass 'inactive'
      $(view.el).hide()
      @views.push(view)

    activate: (view, args) =>
      #console.log 'zoom', view, @activeView
      if @activeView
        @close @activeView
      #$(view.el).removeClass 'inactive' 
      $(view.el).show()
      view.render args
      @activeView = view

    close: (view) ->
      #console.log view, 'sssoooiiiii'
      #_each(view)
      #@unbindFromAll()
      #@unbind()
      $(view.el).html('')
      #view.remove()
      $(view.el).hide()
      #@onClose() 



    
#    # Close the current view, render the given view into @element
#    showView: (view) ->
#      if (@currentView)
#        @currentView.close()
#  
#      this.currentView = view
#      this.currentView.render()
#  
#      $(@element).html(this.currentView.el)
#  
#    # Returns true if element is empty
#    isEmpty: () ->
#      return $(@element).is(':empty')
#  
#  # Augment backbone view to add binding management and close method
#  # Inspired by http://stackoverflow.com/questions/7567404/backbone-js-repopulate-or-recreate-the-view/7607853#7607853
#  _.extend(Backbone.View.prototype, 
#  
#    # Use instead of bind, creates a bind and stores the binding in @bindings
#    bindTo: (model, ev, callback) ->
#      model.bind(ev, callback, this)
#  
#      @bindings = [] unless @bindings?
#      @bindings.push({ model: model, ev: ev, callback: callback })
#  
#    # Unbinds all the bindings in @bindings
#    unbindFromAll: () ->
#      if @bindings?
#        _.each(@bindings, (binding) ->
#          binding.model.unbind(binding.ev, binding.callback))
#      @bindings = []
#  
#    # Clean up all bindings and remove elements from DOM
#    close: () ->
#      @unbindFromAll()
#      @unbind()
#      @remove()
#      @onClose() if @onClose # Some views have specific things to clean up