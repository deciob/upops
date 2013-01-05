define [
  'underscore'
], (_) ->
  'use strict'

  # Pattern from:
  # http://bost.ocks.org/mike/chart/
  # and:
  # http://macwright.org/2012/06/04/the-module-pattern.html
  
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

    renderBaseMap = (svg, path) ->
      #console.log "mapper:renderBaseMap", path.bounds()
      unless c.data.base then return
      base = c.data.base
      world = base.objects.world
      if c.country
        geom = _.filter base.objects.world.geometries, (geom) -> 
          geom.id == c.country
        filtered_world = 
          geometries: geom
          type: "GeometryCollection"
        world = filtered_world
        #console.log 'worl', world
      #graticule = d3.geo.graticule()
      #svg.append("path")
      #  .datum(graticule.outline)
      #  .attr("class", "background").attr "d", path
      #svg.append("g")
      #  .attr("class", "graticule")
      #  .selectAll("path").data(graticule.lines).enter()
      #    .append("path").attr "d", path
      #svg.append("path")
      #  .datum(graticule.outline).attr("class", "foreground").attr "d", path
      svg.insert("path", ".graticule")
        .datum(topojson.object(base, world))
        .attr("class", "land").attr "d", path

      #console.log 'sss', path.bounds('svg[0]')
      #svg.insert("path", ".graticule")
      #  .datum(topojson.mesh(base, base.objects.countries, (a, b) ->
      #    a.id isnt b.id
      #)).attr("class", "boundary").attr "d", path

    renderOverlay = (svg, path) ->
      #console.log "mapper:renderOverlay", svg, c.data, c.data.overlay
      unless c.data.overlay then return
      dataset = c.data.overlay
      #self = @
      g = svg.append("g")
      chart = (row) ->
        #console.log row
        xy = c.projection([
          row.geometry.coordinates[0], 
          row.geometry.coordinates[1]])
        g.append("circle")
          .attr("r", 0)
          .attr("cx", xy[0])
          .attr("cy", xy[1])
          .attr("id", "c_#{row._id}") # namespacing the id
          #.on('click', self.overIncident)
          .transition()
          .duration(2000)
          .attr("r", (d) ->
            # TODO: remove hard-coded `row.POP1950`
            circleDimension(row.POP1950)
          )
      dataset.each(chart, @)

    centreMap = (bounds, centroid, path) ->
      console.log "mapper:centreMap", bounds, centroid, c.width
      scale = getScale(c.width, c.height)
      trans = getTranslation(scale)
      c.projection.scale(scale)
      c.projection.translate([trans.x, trans.y])

    m = ->
      #console.log 'mapper:m', c
      svg = d3.select(c.el)
        .append("svg").attr("width", c.width).attr("height", c.height)
      scale = getScale(c.width, c.height)
      trans = getTranslation(scale)
      c.projection.scale(scale)
      c.projection.translate([trans.x, trans.y])
      path = d3.geo.path().projection(c.projection)
      #console.log path.bounds()
      base_map = renderBaseMap(svg, path)
      bounds = no
      centroid = no
      base_map.each (f, i) -> 
        bounds = path.bounds(f)
        centroid = path.centroid(f)
      renderOverlay(svg, path)
      if c.country
        centreMap(bounds, centroid, path)

    m.updateOverlay = (year) ->
      #console.log 'mapper:updateOverlay', @, year
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