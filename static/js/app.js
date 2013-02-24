
requirejs.config({
  baseUrl: "static/js/",
  paths: {
    jquery: "vendor/jquery-1.8.3.min",
    jquery_ui: "vendor/jquery-ui-1.10.0.custom",
    laconic: "vendor/laconic",
    bootstrap: "vendor/bootstrap",
    underscore: "vendor/miso-0.4.0/lib/lodash",
    deferred: "vendor/miso-0.4.0/lib/underscore.deferred",
    math: "vendor/miso-0.4.0/lib/underscore.math",
    moment: "vendor/miso-0.4.0/lib/moment",
    miso: "vendor/miso-0.4.0/miso.ds.0.4.0",
    backbone: "vendor/backbone",
    text: "vendor/text-2.0.3",
    d3: "vendor/d3",
    projection: "vendor/projection",
    topojson: "vendor/topojson"
  },
  shim: {
    jquery_ui: {
      deps: ["jquery"],
      exports: "jQuery"
    },
    laconic: {
      exports: "laconic"
    },
    bootstrap: {
      exports: "bootstrap"
    },
    underscore: {
      exports: "_"
    },
    deferred: {
      deps: ["underscore"],
      exports: "_deferred"
    },
    math: {
      deps: ["underscore"],
      exports: "_math"
    },
    moment: {
      exports: "moment"
    },
    miso: {
      deps: ["underscore", "deferred", "math", "moment"],
      exports: "Miso"
    },
    backbone: {
      deps: ["jquery", "underscore"],
      exports: "Backbone"
    },
    d3: {
      exports: "d3"
    },
    projection: {
      exports: "projection"
    },
    topojson: {
      exports: "topojson"
    }
  }
});

requirejs(['main']);
