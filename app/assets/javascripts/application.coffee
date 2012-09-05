#= require lib/jquery
#= require lib/underscore
#= require lib/backbone
#= require forge
#= require_tree ./lib
#= require hogan
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers
#= require_self

Backbone.LayoutManager.configure(
  manage: true

  fetch: (path) ->
    HoganTemplates[path]

  render: (template, context) ->
    template.render(context || {})
)

_.extend Backbone.Collection.prototype,
  load: (id) ->
    result = @deferred()
    if record = @get(id)
      result.resolve(record)
    else
      finder = =>
        @off 'reset', finder
        result.resolve(@get(id))
      @on 'reset', finder
    result

  deferred: ->
    jQuery.Deferred()

class @Application

  constructor: ->
    new KeyRouter(app: @, keypair: @keypair)
    new ItemRouter(app: @, keypair: @keypair)
    Backbone.history.start()

  layout: (layout) ->
    unless layout == @current_layout
      @current_layout = layout
      $(document.body).html(layout.el)
      layout.render()
