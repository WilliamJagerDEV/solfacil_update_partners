defmodule SolfacilUpdatePartnersWeb.FallbackController do
  use SolfacilUpdatePartnersWeb, :controller

  alias SolfacilUpdatePartnersWeb.ErrorView

  def call(conn, error) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", result: error)
  end
end
