define [
  'backbone'
], (Backbone) ->
  'use strict'


  class CountryModel extends Backbone.Model

    defaults:     
      country: "world"  #all other countries are in iso_2 code
      year: 1950