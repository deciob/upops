define [
  'underscore'
], (_) ->
  'use strict'

  getMiddleHeight = -> 
    # TODO: pass these ids from some config
    header = $("#top")
    footer = $("#world_info")
    document_h = $(document).height()
    header_h = header.height()
    footer_h = footer.height()
    document_h - header_h - footer_h

  getScale = (width, height, map_dimensions={height: 500, width:960}) ->
    map_proportion = map_dimensions.height / map_dimensions.width
    view_proportion = height / width
    if view_proportion > map_proportion
      factor = 150 / map_dimensions.width
      return width * factor
    else
      factor = 150 / map_dimensions.height
      return height * factor

  getTranslation = (scale, map_dimensions={height: 500, width:960}) ->
    console.log "utils:getTranslation", scale
    x_scale = (map_dimensions.width / 2) / 150 * scale
    y_scale = (map_dimensions.height / 2) / 150 * scale
    x:
      x_scale
    y:
      y_scale

  # Get a unique country list from the 'country_dataset' Miso Dataset.
  getCountryList = (cd) ->
    countries = [{value: "world", code: "world"}]
    cd.each (row) -> 
      countries.push {value: row.Country, code: row.iso_a2}
    _.uniq countries, false, (el) -> el.value

  utils = 
    getMiddleHeight: getMiddleHeight
    getScale: getScale
    getTranslation: getTranslation
    getCountryList: getCountryList




