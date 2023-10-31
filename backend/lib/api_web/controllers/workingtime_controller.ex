defmodule ApiWeb.WorkingtimeController do
  use ApiWeb, :controller

  alias Api.Accounts
  alias Api.Accounts.Workingtime

  action_fallback ApiWeb.FallbackController

  def index(conn, %{"userID" => userID, "start" => start_date, "end" => end_date}) do
    workingtimes = Accounts.find_workingtime_by_start_end(userID, start_date, end_date)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def index(conn, %{"userID" => userID}) do
    workingtimes = Accounts.find_workingtime_by_user_id(userID)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"userID" => userID, "workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- Accounts.create_workingtime(Map.merge(%{"user" => userID}, workingtime_params)) do
      conn
      |> put_status(:created)
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"userID" => userID, "id" => id}) do
    workingtime = Accounts.find_workingtime(userID, id)
    render(conn, "show.json", workingtime: Enum.at(workingtime, 0))
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Accounts.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Accounts.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Accounts.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Accounts.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
