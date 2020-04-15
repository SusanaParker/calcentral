class EnfsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_api_key

  def create
    Notifications::JmsMessageHandler.new.handle({ text: JSON.generate(params[:enf]) })
    ENF::Processor.instance.handle(params[:enf])
    head :ok
  end

  private

  def verify_api_key
    head :unauthorized unless request.headers['X-API-KEY'] == Settings.ist_jms.key
  end
end
