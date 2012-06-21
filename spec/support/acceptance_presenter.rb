class AcceptancePresenter < Prospecto::PresenterView
  accepts :person

  def name
    person.full_name
  end
end
