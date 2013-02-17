
define(['miso'], function(Miso) {
  'use strict';

  var GeoJsonParser;
  return GeoJsonParser = function(dataset) {
    return _.extend(GeoJsonParser.prototype, Miso.Dataset.Parsers.prototype, {
      parse: function(data) {
        var column, columns, dataColumns, features, _getColumns, _i, _len;
        _getColumns = function() {
          return console.log('Needs implementing!');
        };
        columns = dataset.options.columns || _getColumns();
        dataColumns = {
          geometry: []
        };
        for (_i = 0, _len = columns.length; _i < _len; _i++) {
          column = columns[_i];
          dataColumns[column] = [];
        }
        features = data.features;
        _.each(features, function(c) {
          var _j, _len1, _results;
          _results = [];
          for (_j = 0, _len1 = columns.length; _j < _len1; _j++) {
            column = columns[_j];
            if (column === 'geometry') {
              _results.push(dataColumns[column].push(c.geometry));
            } else {
              _results.push(dataColumns[column].push(c.properties[column]));
            }
          }
          return _results;
        });
        return {
          columns: columns,
          data: dataColumns
        };
      }
    });
  };
});
