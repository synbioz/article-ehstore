ArticleEsHstore::Application.routes.draw do
  resources :products do
    collection do
      get 'autocomplete'
      get 'search'
    end
  end
end
