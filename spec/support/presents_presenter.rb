class PresentsPresenter < Prospecto::PresenterView
  presents :person

  def name
    person.name
  end
end
