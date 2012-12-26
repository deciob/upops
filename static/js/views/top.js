// Generated by CoffeeScript 1.4.0

define(['backbone', 'text!templates/top.html'], function(Backbone, template) {
  'use strict';

  var Top;
  return Top = Backbone.View.extend({
    el: "#top",
    initialize: function(options) {
      return this.setElement($(this.el));
    },
    render: function() {
      template = _.template(template);
      return this.$el.html(template);
    }
  });
});
