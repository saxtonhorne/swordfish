class @KeypairAuthenticator
  @ajax: jQuery.ajax

  constructor: (@keypair) ->

  request: ->
    @constructor.ajax(
      type:     'POST'
      url:      '/auth/rsa'
      data:     @keypair.publicKeyPem()
    ).done(@respond)

  respond: ->
