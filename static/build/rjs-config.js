// see: https://github.com/jrburke/almond


({
    baseUrl: '../js',                         
    name: 'vendor/almond',
    paths: {
      d3: 'vendor/d3',
      projection: 'vendor/projection',
      topojson: 'vendor/topojson',
      jquery: 'vendor/jquery-1.8.3.min',
      jquery_ui: 'vendor/jquery-ui-1.9.2.custom',
      bootstrap: 'vendor/bootstrap',
      underscore: 'vendor/miso-0.4.0/lib/lodash',
      deferred: 'vendor/miso-0.4.0/lib/underscore.deferred',
      math: 'vendor/miso-0.4.0/lib/underscore.math',
      moment: 'vendor/miso-0.4.0/lib/moment',
      miso: 'vendor/miso-0.4.0/miso.ds.0.4.0',
      backbone: 'vendor/backbone',
      text: 'vendor/text-2.0.3'
  },
    shim: {
        d3: {
            exports: 'd3'
        },
        projection: {
            exports: 'projection'
        },
        topojson: {
            exports: 'topojson'
        },
        jquery_ui: {
            deps: ['jquery'],
            exports: 'jQuery'
        },
        bootstrap: {
            exports: 'bootstrap'
        },
        underscore: {
            exports: '_'
        },
        deferred: {
            deps: ['underscore'],
            exports: '_deferred'
        },
        math: {
            deps: ['underscore'],
            exports: '_math'
        },
        moment: {
            exports: 'moment'
        },
        miso: {
            deps: ['underscore', 'deferred', 'math', 'moment'],
            exports: 'Miso'
        },
        backbone: {
            deps: ['jquery', 'underscore'],
            exports: 'Backbone'
        }
    },
    include: [
        'd3',
        'projection',
        'topojson', 
        'moment',
        'jquery',
        'jquery_ui',
        'math',
        'backbone',
        'text',

        'router',

        'models/world_info_model', 

        'views/base', 
        'views/country_info', 
        'views/country_map', 
        'views/timeline', 
        'views/top', 
        'views/world_info', 
        'views/world_map'

    ]
   
})