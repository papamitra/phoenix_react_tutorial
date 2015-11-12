defmodule ReactTutorial.CommentController do
  use ReactTutorial.Web, :controller

  alias ReactTutorial.Comment

  plug :scrub_params, "comment" when action in [:create, :update]

  def index(conn, _params) do
    comments = Repo.all(Comment)
    #render(conn, "index.json", comments: comments)
    render(conn, :index, comments: comments)
  end

  def create(conn, %{"comment" => comment_params}) do
    IO.inspect "comment_params:"
    IO.inspect comment_params
    changeset = Comment.changeset(%Comment{}, comment_params)

    case Repo.insert(changeset) do
      {:ok, comment} ->
        conn
        |> put_status(:created)
        |> render(:index, comments: Repo.all(Comment))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ReactTutorial.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Repo.get!(Comment, id)
    changeset = Comment.changeset(comment, comment_params)

    case Repo.update(changeset) do
      {:ok, comment} ->
        render(conn, "show.json", comment: comment)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ReactTutorial.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    send_resp(conn, :no_content, "")
  end
end
