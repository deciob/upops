var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'views/app_title', 'views/country_picker', 'views/map_view', 'views/timeline', 'views/extra_info'], function(Backbone, AppTitle, CountryPicker, MapView, Timeline, ExtraInfo) {
  'use strict';

  var MainView;
  return MainView = (function(_super) {

    __extends(MainView, _super);

    function MainView() {
      return MainView.__super__.constructor.apply(this, arguments);
    }

    MainView.prototype.initialize = function(options) {
      this.views = {};
      this.views.app_title = new AppTitle(options);
      this.views.country_picker = new CountryPicker(options);
      this.views.map_view = new MapView(options);
      this.views.timeline = new Timeline(options);
      return this.render();
    };

    MainView.prototype.render = function() {
      this.views.app_title.render();
      return this.views.country_picker.render();
    };

    return MainView;

  })(Backbone.View);
});
