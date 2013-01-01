define [
  'backbone'
  'libs/utils'
  'text!templates/world_map.html'
], (Backbone, utils, template) ->
  'use strict'


  WorldMap = Backbone.View.extend(

    el: "#world_map"

    initialize: (options) ->
      @options = options or {}
      @dispatcher = options.dispatcher
      #@options.width = 1200
      #@options.height = 800
      #@setElement $(@el)
      @defaultMessage = "World Map (main visualisation)"
      @message = @options.message or @defaultMessage
      @dispatcher.on 'onSlide', @updateChart, @
  
    circleDimension: d3.scale.linear()
      .domain([1000, 38661000])
      .range([2, 30])

    render: (args) ->
      #console.log 'xxx', args
      #template = _.template template#, {message: @message}
      dimensions = @_getViewDimensions()
      width = dimensions.width
      height = dimensions.height
      scale = utils.getScale(width, height) #* .9
      trans = utils.getTranslation(scale)
      @projection = d3.geo.robinson()
      @projection.scale(scale)
      @projection.translate([trans.x, trans.y])
      path = d3.geo.path().projection(@projection)
      svg = d3.select(@el)
        .append("svg").attr("width", width).attr("height", height)
      #@$el.html template
      @renderBaseMap(svg, path, args[1][0])
      #@renderBaseMap(svg, path, JSON.parse(args[1][0])) #TODO: why???? JSON.parse???
      @renderOverlay(svg, path, args[0])
      @dataset = args[0]

    renderBaseMap: (svg, path, world) ->
      # Copied from: http://bl.ocks.org/3682676
      graticule = d3.geo.graticule()
      svg.append("path")
        .datum(graticule.outline)
        .attr("class", "background").attr "d", path
      svg.append("g")
        .attr("class", "graticule")
        .selectAll("path").data(graticule.lines).enter()
          .append("path").attr "d", path
      svg.append("path")
        .datum(graticule.outline).attr("class", "foreground").attr "d", path
      svg.insert("path", ".graticule")
        .datum(topojson.object(world, world.objects.land))
        .attr("class", "land").attr "d", path
      svg.insert("path", ".graticule")
        .datum(topojson.mesh(world, world.objects.countries, (a, b) ->
          a.id isnt b.id
      )).attr("class", "boundary").attr "d", path

    renderOverlay: (svg, path, dataset) ->
      self = @
      g = svg.append("g")
      chart = (row) ->
        #console.log row
        xy = @projection([
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
            #circleDimension(row.POP2010)
            self.circleDimension(row.POP1950)
          )
      dataset.each(chart, @)

    updateChart: (year) ->
      self = @
      d3.select(@el).selectAll("circle").datum ->
        selection = d3.select(@)
        id = selection.attr('id').substring(2)
        pop = self.dataset.rowById(id)["POP#{year}"]
        d3.select(@)
        .transition()
        .duration(500)
        .attr("r", -> self.circleDimension(pop))

    _getViewDimensions: ->
      height:
        utils.getMiddleHeight()
      width:
        $(@el).innerWidth()

        
  )