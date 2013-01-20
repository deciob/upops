define (require) ->

  require ["jquery", "backbone", "router"], ($, Backbone, Router) ->
    $(document).ready ->
      mainRoute = new Router()
      Backbone.history.start()
