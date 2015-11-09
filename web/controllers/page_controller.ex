defmodule ReactTutorial.PageController do
  use ReactTutorial.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
