var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone'], function(Backbone) {
  'use strict';

  var CountryModel;
  return CountryModel = (function(_super) {

    __extends(CountryModel, _super);

    function CountryModel() {
      return CountryModel.__super__.constructor.apply(this, arguments);
    }

    CountryModel.prototype.defaults = {
      country: "world",
      year: 1950
    };

    return CountryModel;

  })(Backbone.Model);
});
