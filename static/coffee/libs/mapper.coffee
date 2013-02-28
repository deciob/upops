define [
  'd3'
  'projection'
  'topojson'
  'underscore'
], (d3, projection, topojson, _) ->
  'use strict'

  # Pattern from:
  # http://bost.ocks.org/mike/chart/
  # and:
  # http://macwright.org/2012/06/04/the-module-pattern.html

  # TODO: need some good refactoring!
  
  mapper = (conf) ->

    # Some default values. 
    defaults = 
      width: 960
      height: 500
      projection: d3.geo.robinson()
    c = _.extend defaults, conf

    circleDimension = d3.scale.linear()
      # TODO: his stuff should not be hard-coded
      .domain([1000, 38661000])
      .range([2, 30])

    ### 
    Private functions  
    ###

    getDataset = (country) ->
      if country == "world"
        return c.data.overlay
      else
        return c.data.overlay.where
          rows: (row) ->
            row["iso_a2"] == country

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
      #console.log "utils:getTranslation", scale
      x_scale = 480 / 150 * scale
      y_scale = 250 / 150 * scale
      x:
        x_scale
      y:
        y_scale

    # The base Map, that for now does not get updated, 
    # so it is only rendered once.
    renderBaseMap = ->
      #console.log "mapper:renderBaseMap
      unless c.data.base then return
      #### Heroku hack!!!! --- TODO: find out why!!! ####
      if typeof c.data.base == "string"  # on Heroku
        base = JSON.parse c.data.base
      else                               # my dev server
        base = c.data.base
      ####
      path = d3.geo.path().projection(c.projection)
      graticule = d3.geo.graticule()
      m.backgroud = m.svg.append("path")
        .datum(graticule.outline)
        .attr("class", "background")
        .attr("d", path)
      m.graticule = m.svg.append("g")
        .attr("class", "graticule")
      .selectAll("path")
        .data(graticule.lines)
      .enter().append("path")
        .attr("d", path)
      world = base.objects.world
      m.svg.selectAll(".country")
        .data(topojson.object(base, world).geometries)
      .enter().append("path")
        .attr("id", (d) -> d.id)
        .attr("d", c.path)
        .attr("class", "country")

    centreMap = (bounds, centroid, path) ->
      #console.log "mapper:centreMap", bounds, centroid, c.width
      scale = getScale(c.width, c.height)
      trans = getTranslation(scale)
      c.projection.scale(scale)
      c.projection.translate([trans.x, trans.y])

    ### 
    Public functions  
    ###

    m = ->
      #console.log 'mapper:m', country
      # The SVG container for the whole map (base map and cities map).
      m.svg = d3.select(c.el)
        .append("svg")
      #.attr("width", c.width).attr("height", c.height)
      .attr("width", "100%")
      .attr("height", "100%")
      .attr("viewBox", "0 0 #{c.width} #{c.height}")
      #.attr("class", "map")
      scale = getScale(c.width, c.height)
      trans = getTranslation(scale)
      c.projection.scale(scale)
      c.projection.translate([trans.x, trans.y])
      c.path = d3.geo.path().projection(c.projection)

    m.render = (country, year) ->
      #console.log 'mapper:render'
      m.base_map = renderBaseMap()
      m.overlay_map = m.updateOverlay(country, year)
      # If the app is initialized with a country...
      if country != "world"  
        m.zoomToCountry country

    m.updateOverlay = (country, year) ->  #svg, path, 
      #console.log "mapper:updateOverlay", country, c.data.overlay
      unless c.data.overlay then return
      setEl = (el) ->
        el
        .attr("r", 0)
        .attr("cx", (d, i) ->
          c.projection([
            d.geometry.coordinates[0],
            d.geometry.coordinates[1]])[0])
        .attr("cy", (d, i) -> 
          c.projection([
            d.geometry.coordinates[0],
            d.geometry.coordinates[1]])[1])
        .attr("id", (d, i) -> "c_#{d._id}")
        #.attr("class", (d, i) -> d.iso_a2)
        .transition()
        .duration(2000)
        .attr("r", (d) ->
          circleDimension d["POP#{year}"] )
      dataset = getDataset(country)
      # If this is the first time the overlay is rendered...
      unless c.circle_g
        c.circle_g = m.svg.append("g").attr("id", "cities_container")
      # DATA JOIN
      cities = c.circle_g.selectAll("circle").data dataset.toJSON()
      # UPDATE
      cities.each (d, i) -> setEl d3.select(@)
      # ENTER
      setEl cities.enter().append("circle")
      # EXIT
      cities.exit().remove()
      # Return the overlay.
      c.circle_g

    m.updateYear = (year) ->
      #console.log 'mapper:updateOverlayYear', year
      d3.select(c.el).selectAll("circle").datum ->
        selection = d3.select(@)
        id = selection.attr('id').substring(2)
        # TODO: remove hard-coded `POP`
        pop = c.data.overlay.rowById(id)["POP#{year}"]
        d3.select(@)
        .transition()
        .duration(500)
        .attr("r", -> circleDimension(pop))
      m

    # TODO: this needs checking and reviewing.
    # TODO: colours should be in config or in css!
    m.zoomToCountry = (country) ->
      # Reset base_map style
      m.base_map.style("fill", "#FFFDF7")
      #m.overlay_map = m.updateOverlay country
      if country != "world"
        el = m.base_map.filter (f, i) ->
          f.id == country
        # Highlight the selected country
        el.style("fill", "#323742")
        d = el.data()[0]
        if d and centered isnt d
          c.centroid = c.path.centroid(d)
          bounds = c.path.bounds(d)
          k = 4
          x = -c.centroid[0] + c.width / 2 / k
          y = -c.centroid[1] + c.height / 2 / k
          centered = d
        else
          centered = null
      else
        x = 0
        y = 0
        k = 1
      tr = "scale(" + k + ")translate(" + x + "," + y + ")"
      m.base_map.selectAll("path").classed "active", centered and (d) ->
        d is centered
      m.base_map.transition().duration(1000)
        .attr("transform", tr)
        .style("stroke-width", .5 / k + "px")
      m.overlay_map.transition().duration(1000)
        .attr("transform", tr)      
      m.overlay_map.selectAll("circle").style("stroke-width", 1 / k + "px")
      m.backgroud.transition().duration(1000)
        .attr("transform", tr)
      m.graticule.transition().duration(1000)
        .attr("transform", tr)
      
    m.el = (value) ->
      return c.el unless arguments.length
      c.el = value
      m

    m.data = (value) ->
      return c.data unless arguments.length
      c.data = value
      m

    # Expects an iso2 country code.
    m.country = (value) ->
      return c.data unless arguments.length
      c.country = value
      m

    m.width = (value) ->
      return c.width unless arguments.length
      c.width = value
      m

    m.height = (value) ->
      return c.height unless arguments.length
      c.height = value
      m

    m.projection = (value) ->
      return c.scale unless arguments.length
      c.projection = value
      m
   
    # Finally, when we've done with t, return it.
    m