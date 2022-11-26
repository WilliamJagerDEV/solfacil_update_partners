defmodule SolfacilUpdatePartnersWeb.PartnersController do
  use SolfacilUpdatePartnersWeb, :controller
  import Ecto. Query
  alias SolfacilUpdatePartners.Repo
  alias SolfacilUpdatePartners.Partners
  alias SolfacilUpdatePartners.Api.CheckCep

  def create(conn, %{"filename" => csv}) do
    csv =
      "#{csv.path}"
      |> Path.expand(__DIR__)
      |> File.stream!()
      |> CSV.decode(headers: true)
      |> Enum.map(fn data -> data end)
      |> Enum.map(fn {:ok, partner} -> update_partner(partner) |> save() end)

    conn
    |> put_status(:ok)
    |> text("Requisição recebida.")
  end

  defp update_partner(partner) do
    partner
    |> update_keys()
    |> update_locale()
  end

  def update_keys(partner) do
    Map.keys(partner)
    |> Enum.reduce(%{}, fn key, map ->
      new_key =
        key
        |> String.downcase()
        |> String.trim()
        |> String.replace(" ", "_")
        |> String.replace("ã", "a")

      value = Map.get(partner, key)
      Map.put(map, new_key, value)
    end)
  end

  defp update_locale(partner) do
    %{"localidade" => cidade, "uf" => estado} = CheckCep.get_address(partner["cep"])
    Map.put(partner, "cidade", cidade) |> Map.put("estado", estado)
  end

  defp save(partner) do
    Partners.changeset(partner)
    |> Repo.insert()
  end

  def index(conn, _params) do
    with list <- list() do
      conn
      |> put_status(:ok)
      |> render("index.json", partners: list)
    end
  end

  defp list do
    Repo.all(from(p in Partners))
  end
end
