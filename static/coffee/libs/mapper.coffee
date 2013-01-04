define [
  'underscore'
], (_) ->
  'use strict'

  # Pattern from:
  # http://bost.ocks.org/mike/chart/
  # See also:
  # http://macwright.org/2012/06/04/the-module-pattern.html
  
  mapper (conf) ->

    # Some default values. 
    defaults = 
      width: 960
      height: 500
      projection: d3.geo.robinson()
    c = _.extend defaults, conf

    m ->
      path = d3.geo.path().projection(projection)

    m.width = (value) ->
      return c.width unless arguments.length
      c.width = value
      m

    m.height = (value) ->
      return c.height unless arguments.length
      c.height = value
      m

    m.scale = (value) ->
      return c.scale unless arguments.length
      c.scale = value
      m

    m.trans = (value) ->
      return c.trans unless arguments.length
      c.trans = value
      m

    
  
    #* Finally, when we've done with t, return it.
    m