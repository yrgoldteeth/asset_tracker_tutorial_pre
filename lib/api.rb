class API < Grape::API
  namespace :api
  get "/:controller" do
    debugger
    {:hello => :world}
  end
end
