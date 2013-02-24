
define(['d3', 'projection', 'topojson', 'underscore'], function(d3, projection, topojson, _) {
  'use strict';

  var mapper;
  return mapper = function(conf) {
    var c, centreMap, circleDimension, defaults, getDataset, getScale, getTranslation, m, renderBaseMap;
    defaults = {
      width: 960,
      height: 500,
      projection: d3.geo.robinson()
    };
    c = _.extend(defaults, conf);
    circleDimension = d3.scale.linear().domain([1000, 38661000]).range([2, 30]);
    /* 
    Private functions
    */

    getDataset = function(country) {
      if (country === "world") {
        return c.data.overlay;
      } else {
        return c.data.overlay.where({
          rows: function(row) {
            return row["iso_a2"] === country;
          }
        });
      }
    };
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
    renderBaseMap = function() {
      var base, graticule, path, world;
      if (!c.data.base) {
        return;
      }
      if (typeof c.data.base === "string") {
        base = JSON.parse(c.data.base);
      } else {
        base = c.data.base;
      }
      path = d3.geo.path().projection(c.projection);
      graticule = d3.geo.graticule();
      m.backgroud = m.svg.append("path").datum(graticule.outline).attr("class", "background").attr("d", path);
      m.graticule = m.svg.append("g").attr("class", "graticule").selectAll("path").data(graticule.lines).enter().append("path").attr("d", path);
      world = base.objects.world;
      return m.svg.selectAll(".country").data(topojson.object(base, world).geometries).enter().append("path").attr("id", function(d) {
        return d.id;
      }).attr("d", c.path).attr("class", "country");
    };
    centreMap = function(bounds, centroid, path) {
      var scale, trans;
      scale = getScale(c.width, c.height);
      trans = getTranslation(scale);
      c.projection.scale(scale);
      return c.projection.translate([trans.x, trans.y]);
    };
    /* 
    Public functions
    */

    m = function() {
      var scale, trans;
      m.svg = d3.select(c.el).append("svg").attr("width", "100%").attr("height", "100%").attr("viewBox", "0 0 " + c.width + " " + c.height);
      scale = getScale(c.width, c.height);
      trans = getTranslation(scale);
      c.projection.scale(scale);
      c.projection.translate([trans.x, trans.y]);
      return c.path = d3.geo.path().projection(c.projection);
    };
    m.render = function(country, year) {
      m.base_map = renderBaseMap();
      m.overlay_map = m.updateOverlay(country, year);
      if (country !== "world") {
        return m.zoomToCountry(country);
      }
    };
    m.updateOverlay = function(country, year) {
      var cities, dataset, setEl;
      if (!c.data.overlay) {
        return;
      }
      setEl = function(el) {
        return el.attr("r", 0).attr("cx", function(d, i) {
          return c.projection([d.geometry.coordinates[0], d.geometry.coordinates[1]])[0];
        }).attr("cy", function(d, i) {
          return c.projection([d.geometry.coordinates[0], d.geometry.coordinates[1]])[1];
        }).attr("id", function(d, i) {
          return "c_" + d._id;
        }).transition().duration(2000).attr("r", function(d) {
          return circleDimension(d["POP" + year]);
        });
      };
      dataset = getDataset(country);
      if (!c.circle_g) {
        c.circle_g = m.svg.append("g").attr("id", "cities_container");
      }
      cities = c.circle_g.selectAll("circle").data(dataset.toJSON());
      cities.each(function(d, i) {
        return setEl(d3.select(this));
      });
      setEl(cities.enter().append("circle"));
      cities.exit().remove();
      return c.circle_g;
    };
    m.updateYear = function(year) {
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
      var bounds, centered, d, el, k, tr, x, y;
      m.base_map.style("fill", "#FFFDF7");
      if (country !== "world") {
        el = m.base_map.filter(function(f, i) {
          return f.id === country;
        });
        el.style("fill", "#860000");
        d = el.data()[0];
        if (d && centered !== d) {
          c.centroid = c.path.centroid(d);
          bounds = c.path.bounds(d);
          k = 4;
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
      tr = "scale(" + k + ")translate(" + x + "," + y + ")";
      m.base_map.selectAll("path").classed("active", centered && function(d) {
        return d === centered;
      });
      m.base_map.transition().duration(1000).attr("transform", tr).style("stroke-width", .5 / k + "px");
      m.overlay_map.transition().duration(1000).attr("transform", tr);
      m.overlay_map.selectAll("circle").style("stroke-width", 1 / k + "px");
      m.backgroud.transition().duration(1000).attr("transform", tr);
      return m.graticule.transition().duration(1000).attr("transform", tr);
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
