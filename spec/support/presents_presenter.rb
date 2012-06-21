class PresentsPresenter < Prospecto::PresenterView
  presents :person

  def name
    person.full_name
  end
end
