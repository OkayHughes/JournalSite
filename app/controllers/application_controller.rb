class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def index
    
  end

  def welcome
    @entries = Entry.all
    @subjects = []
    @entries.each do |entry|
      entry_subjects = entry.subjects.split(",")
      entry_subjects.each do |subject|
        if not (@subjects.include? subject)
            @subjects << subject
        end
      end
    end
    @subjects.sort_by!{ |m| m.downcase }
    @subjects = @subjects.take(3);
    render layout: "splash"
  end
end
