class AcceptancePresenter < Prospecto::PresenterView
  accepts :person

  def name
    person.name
  end
end
