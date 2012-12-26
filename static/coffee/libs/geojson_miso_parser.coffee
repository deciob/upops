define [
  'miso'
], (Miso) ->
  'use strict'

  GeoJsonParser = (dataset) ->

    # a custom parser for geojson data
    
    _.extend GeoJsonParser::, Miso.Dataset.Parsers::,
      parse: (data) ->

        _getColumns = ->
          console.log 'Needs implementing!'
        
        columns = dataset.options.columns or _getColumns()
        dataColumns = {geometry: []}
        for column in columns
          dataColumns[column] = []

        features = data.features
    
        _.each features, (c) ->
          for column in columns
            dataColumns[column].push c.properties[column]

        columns: columns
        data: dataColumns
