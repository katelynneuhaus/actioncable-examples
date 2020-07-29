App.comments = App.cable.subscriptions.create "CommentsChannel",
  collection: -> $("[data-channel='comments']")

  connected: ->
    console.log 'comments.coffee: connected() called'
    # FIXME: While we wait for cable subscriptions to always be finalized before sending messages
    setTimeout =>
      @followCurrentMessage()
      @installPageChangeCallback()
    , 1000

  received: (data) ->
    @collection().append(data.comment) unless @userIsCurrentUser(data.comment)

  userIsCurrentUser: (comment) ->
    $(comment).attr('data-user-id') is $('meta[name=current-user]').attr('id')

  followCurrentMessage: ->
    if messageId = @collection().data('message-id')
      console.log 'comments.coffee: followCurrentSync() follow messageId: ' + messageId
      @perform 'follow', message_id: messageId
    else
      console.log 'comments.coffee: followCurrentSync() unfollow'
      @perform 'unfollow'

  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
      $(document).on 'turbolinks:load', -> App.comments.followCurrentMessage()
