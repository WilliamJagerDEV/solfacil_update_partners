defmodule SolfacilUpdatePartnersWeb.PartnersController do
  use SolfacilUpdatePartnersWeb, :controller
  import Ecto.Query
  alias SolfacilUpdatePartners.Repo
  alias SolfacilUpdatePartners.Partners
  alias SolfacilUpdatePartners.Api.CheckCep

  def create(conn, %{"filename" => file, "client_id" => client_id}) do
    get_csv(file)
    |> Enum.map(fn data -> data end)
    |> Enum.map(fn {:ok, partner} ->
      validate_partner(partner, client_id)
    end)

    conn
    |> put_status(:ok)
    |> text("Requisição recebida.")
  end

  def get_csv(file) do
    file =
      "#{file.path}"
      |> Path.expand(__DIR__)
      |> File.stream!()
      |> CSV.decode(headers: true)
  end

  defp validate_partner(partner, client_id) do
    case check_cnpj(partner["CNPJ"]) do
      true ->
        partner
        |> update_partner_map(client_id)
        |> IO.inspect(label: "LOG PARCEIRO SALVO")
        |> save()

      false ->
        partner
        |> IO.inspect(label: "LOG PARCEIRO NÃO SALVO")
    end
  end

  defp check_cnpj(cnpj) do
    Cpfcnpj.valid?({:cnpj, cnpj})
  end

  defp update_partner_map(partner, client_id) do
    partner
    |> update_keys()
    |> update_map(client_id)
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

  defp update_map(partner, client_id) do
    case CheckCep.get_address(partner["cep"]) do
      {:ok, %{"localidade" => cidade, "uf" => estado}} ->
        Map.put(partner, "cidade", cidade) |> Map.put("estado", estado) |> Map.put("client_id", client_id)

      {:error, %{status_code: _status_code}} ->
        Map.put(partner, "cidade", "cep inválido") |> Map.put("estado", "cep inválido")
    end
  end

  defp save(partner) do
    Partners.changeset(partner)
    |> Repo.insert()
  end

  def index(conn, params) do
    with list <- list(params) do
      conn
      |> put_status(:ok)
      |> render("index.json", partners: list)
    end
  end

  # client_id = 2451549900013822061991 (rafael camarda)

  defp list(%{"id" => client_id}) do
    query = from(
        p in Partners,
        where: p.client_id == ^client_id,
        select: p
      )
    Repo.all(query)
  end
end
