
define(['underscore'], function(_) {
  'use strict';

  var getCountryList, getMiddleHeight, getScale, getTranslation, utils;
  getMiddleHeight = function() {
    var document_h, header, header_h;
    header = $("#top");
    document_h = $(document).height();
    header_h = header.height();
    return (document_h - header_h) * .8;
  };
  getScale = function(width, height, map_dimensions) {
    var factor, map_proportion, view_proportion;
    if (map_dimensions == null) {
      map_dimensions = {
        height: 500,
        width: 960
      };
    }
    map_proportion = map_dimensions.height / map_dimensions.width;
    view_proportion = height / width;
    if (view_proportion > map_proportion) {
      factor = 150 / map_dimensions.width;
      return width * factor;
    } else {
      factor = 150 / map_dimensions.height;
      return height * factor;
    }
  };
  getTranslation = function(scale, map_dimensions) {
    var x_scale, y_scale;
    if (map_dimensions == null) {
      map_dimensions = {
        height: 500,
        width: 960
      };
    }
    console.log("utils:getTranslation", scale);
    x_scale = (map_dimensions.width / 2) / 150 * scale;
    y_scale = (map_dimensions.height / 2) / 150 * scale;
    return {
      x: x_scale,
      y: y_scale
    };
  };
  getCountryList = function(cd) {
    var countries;
    countries = [
      {
        value: "world",
        code: "world"
      }
    ];
    cd.each(function(row) {
      return countries.push({
        value: row.Country,
        code: row.iso_a2
      });
    });
    return _.uniq(countries, false, function(el) {
      return el.value;
    });
  };
  return utils = {
    getMiddleHeight: getMiddleHeight,
    getScale: getScale,
    getTranslation: getTranslation,
    getCountryList: getCountryList
  };
});
