
define(['jquery_ui', 'backbone', 'text!templates/country_picker.html'], function($, Backbone, template) {
  'use strict';

  var CountryPicker;
  return CountryPicker = Backbone.View.extend({
    el: "#country_picker",
    initialize: function(options) {
      this.model = options.model;
      return this.country_list = options.country_list;
    },
    render: function() {
      template = _.template(template);
      this.$el.html(template);
      return this.setCountryPicker();
    },
    setCountryPicker: function() {
      var self;
      self = this;
      return $("#country_tags").autocomplete({
        source: self.country_list,
        select: function(evt, ui) {
          var year;
          year = self.model.get("year");
          return Backbone.history.navigate("country/" + ui.item.code + "/" + year + "/", {
            trigger: true
          });
        }
      });
    }
  });
});
