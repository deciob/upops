define [
  'underscore'
], (_) ->
  'use strict'

  # TODO: for now parked here...
  getWorldViewDimensions = (el) ->
    header = $("#top")
    footer = $("#footer_viz")
    world_view = $(el)
    document_h = $(document).height()
    header_h = header.height()
    footer_h = footer.height()
    height:
      document_h - header_h - footer_h
    width:
      world_view.innerWidth()

  getScale = (width, height) ->
    if width > height
      factor = 150 / 500
      return height * factor
    else
      factor = 150 / 960
      return width * factor

  getTranslation = (scale) ->
    x_scale = 480 / 150 * scale
    y_scale = 250 / 150 * scale
    x:
      x_scale
    y:
      y_scale

  utils = 
    getWorldViewDimensions: getWorldViewDimensions
    getScale: getScale
    getTranslation: getTranslation




