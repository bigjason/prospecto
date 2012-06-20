class NestedDecoratesPresenter < ApplicationPresenter
  decorates :person

  def age
    25
  end
end
