defmodule SolfacilUpdatePartnersWeb.PartnersController do
  use SolfacilUpdatePartnersWeb, :controller

  alias SolfacilUpdatePartners.Partner.Csv
  alias SolfacilUpdatePartners.Partner.Build
  alias SolfacilUpdatePartners.Partner.Get

  def create(conn, %{"filename" => file, "client_id" => client_id}) do
    Csv.get_csv(file)
    |> Enum.map(fn {:ok, partner} ->
      Build.build_partner(partner, client_id)
    end)

    conn
    |> put_status(:ok)
    |> text("Requisição recebida.")
  end

  def list(conn, params) do
    with list <- Get.get_by_client_id(params) do
      conn
      |> put_status(:ok)
      |> render("index.json", partners: list)
    end
  end
end
