define [
  'jquery_ui'
  'backbone'
  'text!templates/top.html'
], ($, Backbone, template) ->
  'use strict'


  Top = Backbone.View.extend(

    el: "#top"

    initialize: (options) ->
      @setElement $(@el)
      @dispatcher = options.dispatcher
  
    render: (ds) ->
      template = _.template template
      @$el.html template
      @setCountryPicker(ds)

    setCountryPicker: (ds) ->
      self = @
      countries = @getCountryList(ds)
      $( "#country_tags" ).autocomplete({
        source: countries
        select: (evt, ui) ->
          self.dispatcher.trigger 'onCountrySelect', ui.item.value
      })

    getCountryList: (ds) ->
      countries = []
      ds.each (row) -> 
        countries.push {label: row.Country, value: row.iso_a2}
      _.uniq countries

  
  )