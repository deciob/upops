
define(['backbone', 'models/world_info_model', 'libs/utils', 'text!templates/extra_info.html'], function(Backbone, WorldInfoModel, utils, template) {
  'use strict';

  var Bookmark, WorldInfo;
  Bookmark = Backbone.View.extend({
    template: _.template(),
    render: function() {
      this.$el.html(this.template(this.model.toJSON()));
      return this;
    }
  });
  return WorldInfo = Backbone.View.extend({
    el: "#extra_info",
    template: _.template(template),
    initialize: function(options) {
      this.options = options || {};
      this.dispatcher = options.dispatcher;
      this.model = new WorldInfoModel();
      this.model.set({
        year: this.options.default_year
      });
      this.listenTo(this.model, "change", this.render);
      return this.dispatcher.on('onSlide', this.updateYear, this);
    },
    render: function() {
      return this.$el.html(this.template({
        model: this.model.toJSON()
      }));
    },
    updateYear: function(year) {
      return this.model.set({
        year: year
      });
    }
  });
});
