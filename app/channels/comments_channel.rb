#*DTA Here!
class CommentsChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams # Unsubscribes all streams associated with this channel from the pubsub queue. I'm not sure if this belongs in follow.
    Rails.logger.debug("hi we're following a commentschannel")
    stream_from "messages:#{data['message_id'].to_i}:comments"
  end

  def unfollow
    stop_all_streams
  end
end
