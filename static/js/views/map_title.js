var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'laconic'], function(Backbone, laconic) {
  'use strict';

  var MapTitle;
  return MapTitle = (function(_super) {

    __extends(MapTitle, _super);

    function MapTitle() {
      return MapTitle.__super__.constructor.apply(this, arguments);
    }

    MapTitle.prototype.el = "#map_title";

    MapTitle.prototype.initialize = function(options) {
      var _this = this;
      this.model = options.model;
      this.country_list = options.country_list;
      return this.listenTo(this.model, "change:country", function(model, year) {
        return _this.render();
      });
    };

    MapTitle.prototype.render = function() {
      var code, country, title, year;
      year = this.model.get('year');
      code = this.model.get('country');
      country = _.find(this.country_list, function(el) {
        return el.code === code;
      });
      title = "" + country.value + " - " + year;
      return this.$el.html($.el.h4({
        'class': 'title'
      }, title));
    };

    return MapTitle;

  })(Backbone.View);
});
