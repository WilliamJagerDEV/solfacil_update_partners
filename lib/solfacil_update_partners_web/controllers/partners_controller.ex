defmodule SolfacilUpdatePartnersWeb.PartnersController do
  use SolfacilUpdatePartnersWeb, :controller
  alias SolfacilUpdatePartners.Repo
  alias SolfacilUpdatePartners.Partners

  def create(conn, %{"filename" => csv}) do
    csv =
      "#{csv.path}"
      |> Path.expand(__DIR__)
      |> File.stream!()
      |> CSV.decode(headers: true)
      |> Enum.map(fn data -> data end)
      |> Enum.map(fn {:ok, partner} -> update_keys(partner) |> handle() end)

    conn
    |> put_status(:ok)
    |> text("Requisição recebida.")
  end

  defp handle(partner) do
    Partners.changeset(partner)
    |> Repo.insert()
  end

  def update_keys(partner) do
    Map.keys(partner)
    |> Enum.reduce(%{}, fn key, map ->
      new_key = key
      |> String.downcase()
      |> String.trim()
      |> String.replace(" ", "_")
      |> String.replace("ã", "a")

      value = Map.get(partner, key)
      Map.put(map, new_key, value)
    end)
  end


  










  # SolfacilUpdatePartnersWeb.PartnersController.teste
  def teste do
    partner =
      %{
        "cep" => "69314-690",
        "cnpj" => "19.478.819/0001-97",
        "email" => "atendimentosoldamanha.com",
        "nome_fantasia" => "Sol da Manhã LTDA",
        "razao_social" => "Sol da Manhã",
        "telefone" => "(21) 98207-9902"
      }
      |> Partners.changeset()

    Repo.insert(partner)
  end
end
