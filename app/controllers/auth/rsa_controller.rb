class Auth::RsaController < ApplicationController
  skip_before_filter :sign_in_required

  def create
    challenge = RsaChallenge::Request.new(request.raw_post)
    render :json => challenge.value
  end

  def update
    challenge = RsaChallenge::Response.new(request.raw_post)
    if challenge.valid?
      head 200
    else
      head 401
    end
  end
end