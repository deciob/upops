// Testacular configuration
// Generated on Sat Feb 23 2013 16:42:16 GMT+0000 (GMT)


// base path, that will be used to resolve files and exclude
basePath = '';


// list of files / patterns to load in the browser
files = [
  MOCHA,
  MOCHA_ADAPTER,
  REQUIRE,
  REQUIRE_ADAPTER,

  {pattern: 'node_modules/chai/chai.js', included: false},

  "js/vendor/jquery-1.8.3.min.js",
  "js/vendor/jquery-ui-1.10.0.custom.js",
  "js/vendor/laconic.js",
  "js/vendor/bootstrap.js",
  "js/vendor/lodash.js",
  "js/vendor/miso-0.4.0/lib/underscore.deferred.js",
  "js/vendor/miso-0.4.0/lib/underscore.math.js",
  "js/vendor/miso-0.4.0/lib/moment.js",
  "js/vendor/miso-0.4.0/miso.ds.0.4.0.js",
  "js/vendor/backbone.js",
  //"js/vendor/text-2.0.3.js",
  "js/vendor/d3.js",
  "js/vendor/projection.js",
  "js/vendor/topojson.js",

  {pattern: 'js/**/*.js', included: false},

  {pattern: 'test/MyModule.test.js', included: false},

  'test/test-main.js',
  
];


// list of files to exclude
exclude = [
  
];


// test results reporter to use
// possible values: 'dots', 'progress', 'junit'
reporters = ['progress'];


// web server port
port = 9876;


// cli runner port
runnerPort = 9100;


// enable / disable colors in the output (reporters and logs)
colors = true;


// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;


// enable / disable watching file and executing tests whenever any file changes
autoWatch = false;


// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
browsers = ['Chrome'];


// If browser does not capture in given timeout [ms], kill it
captureTimeout = 60000;


// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = false;
