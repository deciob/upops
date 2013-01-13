define [
  'jquery_ui'
  'backbone'
  'text!templates/country_picker.html'
], ($, Backbone, template) ->
  'use strict'


  CountryPicker = Backbone.View.extend(

    el: "#country_picker"

    initialize: (options) ->
      @model = options.model
      @country_list = options.country_list
  
    render: ->
      template = _.template template
      @$el.html template
      @setCountryPicker()

    # Initializes the JQuery UI Autocomplete widget.
    setCountryPicker: ->
      self = @
      $( "#country_tags" ).autocomplete
        source: self.country_list
        select: (evt, ui) ->
          Backbone.history.navigate "country/#{ui.item.value}/", trigger: true


  )