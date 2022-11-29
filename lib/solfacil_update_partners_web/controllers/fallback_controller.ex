defmodule SolfacilUpdatePartnersWeb.FallbackController do
  use SolfacilUpdatePartnersWeb, :controller

  def call(conn, error) do
    IO.inspect(error, label: "ERROR NO FALLBACK")
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", result: error)
  end



  # false ->
  #       Logger.info(%{
  #         partner_cnpj: partner["cnpj"],
  #         status: "Não salvo",
  #         msg: "CNPJ não salvo por ser inválido"
  #       })



  #     _ ->
  #       Logger.info(%{
  #         status: "Não salvo",
  #         msg: "CNPJ não salvo. Problemas com Map"
  #       })

  #       Logger.info(%{partner_cnpj: partner["cnpj"], status: "Atualizado", msg: "CNPJ atualizado"})

end
