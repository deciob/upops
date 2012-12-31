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

  getScale = (width, height) ->
    map_proportion = 500 / 960
    view_proportion = height / width
    if view_proportion > map_proportion
      factor = 150 / 960
      return width * factor
    else
      factor = 150 / 500
      return height * factor

  getTranslation = (scale) ->
    x_scale = 480 / 150 * scale
    y_scale = 250 / 150 * scale
    x:
      x_scale
    y:
      y_scale

  utils = 
    getMiddleHeight: getMiddleHeight
    getScale: getScale
    getTranslation: getTranslation




