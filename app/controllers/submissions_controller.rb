class SubmissionsController < ApplicationController
  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(entry_params)

      if @submission.save
        redirect_to "entries#index"
      else
        redirect_to "entries#index"
      end
  end

  private
    def entry_params
      params[:submission]
    end
end
