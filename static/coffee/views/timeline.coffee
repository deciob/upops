define [
  'd3'
  'jquery_ui'
  'backbone'
  'libs/utils'
  'text!templates/timeline.html'
], (d3, $, Backbone, utils, template) ->
  'use strict'


  Timeline = Backbone.View.extend(

    el: "#timeline"

    initialize: (options) ->
      #@setElement $(@el)
      # margin: top, right, bottom, left
      @m = [40, 80, 40, 40]
      @dispatcher = options.dispatcher
  
    render: (args) ->
      @dimensions = @_getViewDimensions()
      $(@el).height(@dimensions.height * .8)
      template = _.template template
      @$el.html template
      @renderTimeseries(args)
      @renderSlider()

    renderSlider: ->
      self = @
      $("#slider")
      .width(@dimensions.width - @m[1] - @m[3])
      .css("left", @m[3])
      .slider
        value: 100
        min: 1950
        max: 2025
        step: 5
        slide: (event, ui) ->
          self.dispatcher.trigger 'onSlide', ui.value

    renderTimeseries: (dataset) ->
      # Copied from: http://bl.ocks.org/1166403
      buffer_zone = 30
      
      m = @m
      w = @$el.width() - m[1] - m[3]
      h = @$el.height() - m[0] - m[2]
      parse = d3.time.format("%Y").parse
      el = @el
      
      # Scales and axes. Note the inverted domain for the y-scale: bigger is up!
      #x = d3.time.scale().range([0, w])
      x = d3.scale.linear().range([0, w])
      y = d3.scale.linear().range([h, 0])
      xAxis = d3.svg.axis().scale(x).tickSize(-h).tickSubdivide(no)
      yAxis = d3.svg.axis().scale(y).ticks(4).orient("right")
      
      # A line generator, for the dark stroke.
      line = d3.svg.line().interpolate("monotone").x((d) ->
        #console.log d.year
        x d.year
      ).y((d) ->
        #console.log d.pop
        y d.pop
      )

      # Add the minimum and maximum date, and the maximum pop.
      x.domain [1950, 2025]
      y.domain [0, 38661000]
      #  y.domain([0, d3.max(values, (d) ->
      #    d.price
      #  )]).nice()

      # Add an SVG element with the desired dimensions and margin.
      svg = d3.select(el).append("svg:svg")
      .attr("width", w + m[1] + m[3])
      #TODO: 55 is to account for everything else in the footer
      .attr("height", h + m[0] + m[2] - 60)  
        .append("svg:g")
      .attr("transform", "translate(" + m[3] + ",0)")
      
      # Add the clip path.
      #svg.append("svg:clipPath").attr("id", "clip").append("svg:rect").attr("width", w).attr "height", h
      
      # Add the x-axis.
      svg.append("svg:g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + h + ")").call xAxis
      
      # Add the y-axis.
      svg.append("svg:g")
      .attr("class", "y axis")
      .attr("transform", "translate(" + w + ",0)").call yAxis
      
      renderLine = (row) ->
        values = []
        name = row.Urban_Aggl
        country = row.Country
        id = row._id
        for k, v of row
          #console.log k, v, k.indexOf "POP"
          if k.indexOf("POP") != -1
            values.push
              country: country
              name: name
              id: id
              year: parseInt k.slice(3)
              pop: v
        svg.append("svg:path")
        .attr("class", "line")
        #.attr("clip-path", "url(#clip)")
        .attr "d", line(values)
        #console.log values
      

      count = 0
      chart = (row) ->
        #console.log row
        #if count == 0
        renderLine(row)
        #  count = 1

      dataset.each(chart, @)


    _getViewDimensions: ->
      height:
        utils.getMiddleHeight()
      width:
        $(@el).innerWidth()

      #d3.csv "readme.csv", (data) ->
      #  
      #  # Filter to one symbol; the S&P 500.
      #  values = data.filter((d) ->
      #    d.symbol is "S&P 500"
      #  )
      #  
      #  # Parse dates and numbers. We assume values are sorted by date.
      #  values.forEach (d) ->
      #    d.date = parse(d.date)
      #    d.price = +d.price
      #
      #  
      #  # Compute the minimum and maximum date, and the maximum price.
      #  x.domain [values[0].date, values[values.length - 1].date]
      #  y.domain([0, d3.max(values, (d) ->
      #    d.price
      #  )]).nice()
      #  
      #  # Add an SVG element with the desired dimensions and margin.
      #  svg = d3.select("body").append("svg:svg").attr("width", w + m[1] + m[3]).attr("height", h + m[0] + m[2]).append("svg:g").attr("transform", "translate(" + m[3] + "," + m[0] + ")")
      #  
      #  # Add the clip path.
      #  svg.append("svg:clipPath").attr("id", "clip").append("svg:rect").attr("width", w).attr "height", h
      #  
      #  # Add the x-axis.
      #  svg.append("svg:g").attr("class", "x axis").attr("transform", "translate(0," + h + ")").call xAxis
      #  
      #  # Add the y-axis.
      #  svg.append("svg:g").attr("class", "y axis").attr("transform", "translate(" + w + ",0)").call yAxis
      #  
      #  # Add the line path.
      #  svg.append("svg:path").attr("class", "line").attr("clip-path", "url(#clip)").attr "d", line(values)
      #  
      #  # Add a small label for the symbol name.
      #  svg.append("svg:text").attr("x", w - 6).attr("y", h - 6).attr("text-anchor", "end").text values[0].symbol

  
  )