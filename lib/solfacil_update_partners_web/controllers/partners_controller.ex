defmodule SolfacilUpdatePartnersWeb.PartnersController do
  use SolfacilUpdatePartnersWeb, :controller
  alias SolfacilUpdatePartners.Partner.Validate
  alias SolfacilUpdatePartners.Partner.Csv
  alias SolfacilUpdatePartners.Partner.Build
  alias SolfacilUpdatePartners.Partner.Get
  alias SolfacilUpdatePartnersWeb.FallbackController

  action_fallback FallbackController

  def create(conn, %{"filename" => file, "client_id" => client_id}) do
    with return when is_list(return) <- Validate.validate_partners(file, client_id) do
      conn
      |> put_status(:ok)
      |> text("Requisição recebida.")
    end
  end

  def list(conn, params) do
    with list <- Get.get_by_client_id(params) do
      conn
      |> put_status(:ok)
      |> render("index.json", partners: list)
    end
  end
end
