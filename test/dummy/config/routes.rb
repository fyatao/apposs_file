Rails.application.routes.draw do

  root :to => "home#index"

  mount AppossFile::Engine => "/apposs_file"
end
