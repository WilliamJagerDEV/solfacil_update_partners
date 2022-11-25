defmodule SolfacilUpdatePartnersWeb.PartnersController do
  use SolfacilUpdatePartnersWeb, :controller

  # def create(conn, params) do
  #   IO.inspect(params["filename"])
  #   conn
  #     |> put_status(:ok)
  #     |> IO.inspect()
  #     |> text("Requisição recebida.")
  # end

  def create(conn, %{"filename" => csv}) do
    csv =
      "#{csv.path}"
      |> Path.expand(__DIR__)
      |> File.stream!()
      |> CSV.decode(headers: true)
      |> Enum.map(fn data -> data end)
      |> IO.inspect()

    conn
    |> put_status(:ok)
    |> text("Requisição recebida.")
  end
end
