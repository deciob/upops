// Generated by CoffeeScript 1.4.0

define(['jquery_ui', 'backbone', 'text!templates/timeline.html'], function($, Backbone, template) {
  'use strict';

  var Timeline;
  return Timeline = Backbone.View.extend({
    el: "#timeline",
    initialize: function(options) {
      this.dispatcher = options.dispatcher;
      return this.m = [40, 80, 40, 40];
    },
    render: function(args) {
      template = _.template(template);
      this.$el.html(template);
      this.renderTimeseries(args);
      return this.renderSlider();
    },
    renderSlider: function() {
      var self;
      self = this;
      return $("#slider").width(this.$el.width() - this.m[1] - this.m[3]).css("left", this.m[3]).slider({
        value: 100,
        min: 1950,
        max: 2025,
        step: 5,
        slide: function(event, ui) {
          return self.dispatcher.trigger('onSlide', ui.value);
        }
      });
    },
    renderTimeseries: function(dataset) {
      var buffer_zone, chart, count, el, h, line, m, parse, renderLine, svg, w, x, xAxis, y, yAxis;
      buffer_zone = 30;
      m = this.m;
      w = this.$el.width() - m[1] - m[3];
      h = this.$el.height() - m[0] - m[2];
      parse = d3.time.format("%Y").parse;
      el = this.el;
      x = d3.scale.linear().range([0, w]);
      y = d3.scale.linear().range([h, 0]);
      xAxis = d3.svg.axis().scale(x).tickSize(-h).tickSubdivide(false);
      yAxis = d3.svg.axis().scale(y).ticks(4).orient("right");
      line = d3.svg.line().interpolate("monotone").x(function(d) {
        return x(d.year);
      }).y(function(d) {
        return y(d.pop);
      });
      x.domain([1950, 2025]);
      y.domain([0, 38661000]);
      svg = d3.select(el).append("svg:svg").attr("width", w + m[1] + m[3]).attr("height", h + m[0] + m[2] - 60).append("svg:g").attr("transform", "translate(" + m[3] + ",0)");
      svg.append("svg:g").attr("class", "x axis").attr("transform", "translate(0," + h + ")").call(xAxis);
      svg.append("svg:g").attr("class", "y axis").attr("transform", "translate(" + w + ",0)").call(yAxis);
      renderLine = function(row) {
        var country, id, k, name, v, values;
        values = [];
        name = row.Urban_Aggl;
        country = row.Country;
        id = row._id;
        for (k in row) {
          v = row[k];
          if (k.indexOf("POP") !== -1) {
            values.push({
              country: country,
              name: name,
              id: id,
              year: parseInt(k.slice(3)),
              pop: v
            });
          }
        }
        return svg.append("svg:path").attr("class", "line").attr("d", line(values));
      };
      count = 0;
      chart = function(row) {
        return renderLine(row);
      };
      return dataset.each(chart, this);
    }
  });
});