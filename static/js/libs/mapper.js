// Generated by CoffeeScript 1.4.0

define(['underscore'], function(_) {
  'use strict';

  var mapper;
  return mapper = function(conf) {
    var c, centreMap, circleDimension, defaults, getScale, getTranslation, m, renderBaseMap, renderOverlay;
    defaults = {
      width: 960,
      height: 500,
      projection: d3.geo.robinson()
    };
    c = _.extend(defaults, conf);
    circleDimension = d3.scale.linear().domain([1000, 38661000]).range([2, 30]);
    getScale = function(width, height) {
      var factor, map_proportion, view_proportion;
      map_proportion = 500 / 960;
      view_proportion = height / width;
      if (view_proportion > map_proportion) {
        factor = 150 / 960;
        return width * factor;
      } else {
        factor = 150 / 500;
        return height * factor;
      }
    };
    getTranslation = function(scale) {
      var x_scale, y_scale;
      x_scale = 480 / 150 * scale;
      y_scale = 250 / 150 * scale;
      return {
        x: x_scale,
        y: y_scale
      };
    };
    renderBaseMap = function(svg, path) {
      var base, graticule, world;
      if (!c.data.base) {
        return;
      }
      base = c.data.base;
      world = base.objects.world;
      graticule = d3.geo.graticule();
      return svg.selectAll(".country").data(topojson.object(base, world).geometries).enter().append("path").attr("id", function(d) {
        return d.id;
      }).attr("d", path).attr("class", "country");
    };
    renderOverlay = function(svg, path, country) {
      var cities, dataset;
      console.log("mapper:renderOverlay", country);
      if (!c.data.overlay) {
        return;
      }
      if (country) {
        dataset = ds.where({
          rows: function(row) {
            return row["iso_a2"] === country_code;
          }
        });
      } else {
        dataset = c.data.overlay;
      }
      if (!c.circle_g) {
        c.circle_g = svg.append("g").attr("id", "cities_container");
      }
      cities = c.circle_g.selectAll("circle").data(dataset.toJSON());
      cities.enter().append("circle").attr("r", 0).attr("cx", function(d, i) {
        return c.projection([d.geometry.coordinates[0], d.geometry.coordinates[1]])[0];
      }).attr("cy", function(d, i) {
        return c.projection([d.geometry.coordinates[0], d.geometry.coordinates[1]])[1];
      }).attr("id", function(d, i) {
        return "c_" + d._id;
      }).transition().duration(2000).attr("r", function(d) {
        return circleDimension(d.POP1950);
      });
      console.log('exit', dataset.toJSON());
      cities.exit().remove();
      return c.circle_g;
    };
    centreMap = function(bounds, centroid, path) {
      var scale, trans;
      scale = getScale(c.width, c.height);
      trans = getTranslation(scale);
      c.projection.scale(scale);
      return c.projection.translate([trans.x, trans.y]);
    };
    m = function(country) {
      var bounds, centroid, scale, svg, trans;
      console.log('mapper:m', c);
      svg = d3.select(c.el).append("svg").attr("width", c.width).attr("height", c.height);
      scale = getScale(c.width, c.height);
      trans = getTranslation(scale);
      c.projection.scale(scale);
      c.projection.translate([trans.x, trans.y]);
      c.path = d3.geo.path().projection(c.projection);
      m.base_map = renderBaseMap(svg, c.path);
      bounds = false;
      centroid = false;
      if (country) {
        return m.zoomToCountry(country);
      } else {
        return m.overlay_map = renderOverlay(svg, c.path);
      }
    };
    m.updateOverlay = function(year) {
      d3.select(c.el).selectAll("circle").datum(function() {
        var id, pop, selection;
        selection = d3.select(this);
        id = selection.attr('id').substring(2);
        pop = c.data.overlay.rowById(id)["POP" + year];
        return d3.select(this).transition().duration(500).attr("r", function() {
          return circleDimension(pop);
        });
      });
      return m;
    };
    m.zoomToCountry = function(country) {
      var bounds, centered, d, el, k, x, y;
      m.base_map.style("fill", "#FFFDF7");
      renderOverlay(false, country);
      if (country) {
        el = m.base_map.filter(function(f, i) {
          return f.id === country;
        });
        el.style("fill", "#860000");
        d = el.data()[0];
        if (d && centered !== d) {
          c.centroid = c.path.centroid(d);
          bounds = c.path.bounds(d);
          k = 5;
          x = -c.centroid[0] + c.width / 2 / k;
          y = -c.centroid[1] + c.height / 2 / k;
          centered = d;
        } else {
          centered = null;
        }
      } else {
        x = 0;
        y = 0;
        k = 1;
      }
      m.base_map.selectAll("path").classed("active", centered && function(d) {
        return d === centered;
      });
      m.base_map.transition().duration(1000).attr("transform", "scale(" + k + ")translate(" + x + "," + y + ")").style("stroke-width", .5 / k + "px");
      m.overlay_map.transition().duration(1000).attr("transform", "scale(" + k + ")translate(" + x + "," + y + ")");
      return m.overlay_map.selectAll("circle").style("stroke-width", 1 / k + "px");
    };
    m.el = function(value) {
      if (!arguments.length) {
        return c.el;
      }
      c.el = value;
      return m;
    };
    m.data = function(value) {
      if (!arguments.length) {
        return c.data;
      }
      c.data = value;
      return m;
    };
    m.country = function(value) {
      if (!arguments.length) {
        return c.data;
      }
      c.country = value;
      return m;
    };
    m.width = function(value) {
      if (!arguments.length) {
        return c.width;
      }
      c.width = value;
      return m;
    };
    m.height = function(value) {
      if (!arguments.length) {
        return c.height;
      }
      c.height = value;
      return m;
    };
    m.projection = function(value) {
      if (!arguments.length) {
        return c.scale;
      }
      c.projection = value;
      return m;
    };
    return m;
  };
});
