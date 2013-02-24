var tests = Object.keys(window.__testacular__.files).filter(function (file) {
  return /\.test\.js$/.test(file);
});

require({
  // Testacular serves files from '/base'
  baseUrl: '/base/js',
    paths: {
    jquery: "vendor/jquery-1.8.3.min",
    jquery_ui: "vendor/jquery-ui-1.10.0.custom",
    laconic: "vendor/laconic",
    bootstrap: "vendor/bootstrap",
    underscore: "vendor/lodash",
    deferred: "vendor/miso-0.4.0/lib/underscore.deferred",
    math: "vendor/miso-0.4.0/lib/underscore.math",
    moment: "vendor/miso-0.4.0/lib/moment",
    miso: "vendor/miso-0.4.0/miso.ds.0.4.0",
    backbone: "vendor/backbone",
    text: "vendor/text",
    d3: "vendor/d3",
    projection: "vendor/projection",
    topojson: "vendor/topojson",
    chai: "../node_modules/chai/chai"
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
    },
    chai: {
      exports: "chai"
    }
  },
  // ask requirejs to load these files (all our tests)
  deps: tests,
  // start test run, once requirejs is done
  callback: window.__testacular__.start
});