var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['d3', 'jquery_ui', 'backbone', 'libs/utils', 'libs/mediator', 'text!templates/timeline.html'], function(d3, $, Backbone, utils, mediator, template) {
  'use strict';

  var Timeline;
  return Timeline = (function(_super) {

    __extends(Timeline, _super);

    function Timeline() {
      this.updateYear = __bind(this.updateYear, this);
      return Timeline.__super__.constructor.apply(this, arguments);
    }

    Timeline.prototype.mediator = mediator;

    Timeline.prototype.el = "#timeline";

    Timeline.prototype.initialize = function(options) {
      this.model = options.model;
      this.year = this.model.get("year");
      this.country = this.model.get("country");
      this.cities_dataset = options.cities_dataset;
      this.m = [40, 80, 40, 40];
      return this.render();
    };

    Timeline.prototype.render = function() {
      var _this = this;
      this.dimensions = this._getViewDimensions();
      this.$el.height(this.dimensions.height * .8);
      template = _.template(template);
      this.$el.html(template);
      this.renderTimeseries();
      this.renderSlider();
      return this.listenTo(this.model, "change:year", function(model, year) {
        return _this.updateYear(year);
      });
    };

    Timeline.prototype.updateYear = function(year) {
      return $("#slider").slider("value", year);
    };

    Timeline.prototype.renderSlider = function() {
      var self;
      self = this;
      return $("#slider").width(this.dimensions.width - this.m[1] - this.m[3]).css("left", this.m[3]).slider({
        value: self.model.get('year'),
        min: 1950,
        max: 2025,
        step: 5,
        slide: function(event, ui) {
          return self.mediator.trigger('onSlide', ui.value);
        },
        stop: function(event, ui) {
          return Backbone.history.navigate("country/" + (self.model.get('country')) + "/" + ui.value + "/", {
            trigger: true
          });
        }
      });
    };

    Timeline.prototype.renderTimeseries = function() {
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
      return this.cities_dataset.each(chart, this);
    };

    Timeline.prototype._getViewDimensions = function() {
      return {
        height: utils.getMiddleHeight(),
        width: $(this.el).innerWidth()
      };
    };

    return Timeline;

  })(Backbone.View);
});
