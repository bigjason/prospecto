class DecoratesPresenter < Prospecto::PresenterView
  decorates :person

  def age
    25
  end
end
