// Generated by CoffeeScript 1.4.0

define(['backbone', 'text!templates/footer_viz.html'], function(Backbone, template) {
  'use strict';

  var FooterViz;
  return FooterViz = Backbone.View.extend({
    el: "#footer_viz",
    initialize: function(options) {
      return this.setElement($(this.el));
    },
    render: function() {
      template = _.template(template);
      return this.$el.html(template);
    }
  });
});
