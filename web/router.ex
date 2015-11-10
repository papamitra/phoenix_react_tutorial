defmodule ReactTutorial.Router do
  use ReactTutorial.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ReactTutorial do
    pipe_through :browser # Use the default browser stack

    get "/public/index.html", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReactTutorial do
  #   pipe_through :api
  # end
end
