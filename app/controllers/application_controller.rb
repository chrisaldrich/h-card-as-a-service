class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def edit_person_path(person)
    [
      nil,
      person.domain,
      "edit"
    ].join("/")
  end
  helper_method :edit_person_path

  def person_path(person)
    [
      nil,
      person.domain,
    ].join("/")
  end
  helper_method :person_path
end
