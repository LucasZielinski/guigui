defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    post "/workingtimes/:userID", WorkingtimeController, :create
    get "/workingtimes/:userID/:id", WorkingtimeController, :show
    get "/workingtimes/:userID", WorkingtimeController, :index
    resources "/workingtimes", WorkingtimeController, except: [:new, :edit, :index, :create, :show]
    post "/clocks/:userID", ClockController, :create
    get "/clocks/:userID", ClockController, :index
    delete "/clocks/:id", ClockController, :delete
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
    end
  end
end
