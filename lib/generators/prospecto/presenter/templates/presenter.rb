class <%= class_name %>Presenter < <%= base_class %>
  # Use of the Prospecto::PresenterView is completely optional and just gives a
  # little initialization sugar. Ala:
  #
  # Create a private accessor:
  #   accepts :<%= single_name %>
  #
  # Create a public accessor:
  #   presents :<%= single_name %>_public
  #
  # Create named proxy methods:
  #   proxies :<%= single_name %>
end
