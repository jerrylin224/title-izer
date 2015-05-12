class MessagesController < ApplicationController

  def create
    @conversation = Conversation.find(params[:conversation_id])
    if message_params[:body].empty?
      @message =  @conversation.messages.build(:body => "Title: " + TitleGenerator.generate_title)
    else
      @message = @conversation.messages.build(message_params)
    end
    
    @message.user_id = current_user.id
    @message.save!
    @path = conversation_path(@conversation)
  end

  private

    def message_params
      params.require(:message).permit(:body)
    end

end
