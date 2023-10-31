defmodule ApiWeb.ClockController do
  use ApiWeb, :controller

  alias Api.Accounts
  alias Api.Accounts.Clock

  action_fallback ApiWeb.FallbackController

  def index(conn, %{"userID" => userID}) do
    clocks = Accounts.find_clock(userID)
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"userID" => userID, "clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Accounts.create_clock(Map.merge(%{"user" => userID}, clock_params)) do
      conn
      |> put_status(:created)
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Accounts.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Accounts.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Accounts.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Accounts.get_clock!(id)

    with {:ok, %Clock{}} <- Accounts.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
