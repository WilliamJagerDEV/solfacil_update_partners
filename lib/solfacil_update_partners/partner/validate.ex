defmodule SolfacilUpdatePartners.Partner.Validate do
  alias SolfacilUpdatePartners.Api.CheckCep
  alias SolfacilUpdatePartners.Partner.Save

  @doc """
  Caso númeor de cnpj esteja no padrão, esta função valida os dados um parceiro antes que sejam salvos, formatando key_words e inserindo cidade e estado caso cep esteja válido.

  ## Examples

    iex> SolfacilUpdatePartners.Partner.Validate.validate_partner(
    iex(1)>  %{
    iex(2)>    " CEP" => "1234",
    iex(3)>    "CNPJ" => "22783-115",
    iex(4)>    "Email" => "atendimento@solenergia.com",
    iex(5)>    "Nome Fantasia" => "Sol Energia LTDA",
    iex(6)>    "Razão Social" => "Sol Energia",
    iex(7)>    "Telefone" => ""
    iex(8)>   },
    iex(9)>   "2451549900013822061991"
    iex(10)> )

      {:ok,
        %SolfacilUpdatePartners.Partners{
          __meta__: #Ecto.Schema.Metadata<:loaded, "partners">,
          id: 2,
          nome_fantasia: "Sol da Manhã LTDA",
          razao_social: "Sol da Manhã",
          cnpj: "19.478.819/0001-97",
          telefone: "(21) 98207-9902",
          cep: "69314-690",
          cidade: "Boa Vista",
          estado: "RR",
          client_id: "2451549900013822061991"
        }
      }

  """

  def validate_partner(partner, client_id) do
    case Cpfcnpj.valid?({:cnpj, partner["CNPJ"]}) do
      true ->
        partner
        |> update_keys()
        |> update_map(client_id)
        |> IO.inspect(label: "LOG PARCEIRO SALVO")
        |> Save.save_partner()

      false ->
        partner
        |> IO.inspect(label: "LOG PARCEIRO NÃO SALVO")
    end
  end

  defp update_keys(partner) do
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
        Map.put(partner, "cidade", cidade)
        |> Map.put("estado", estado)
        |> Map.put("client_id", client_id)

      {:error, %{status_code: _status_code}} ->
        Map.put(partner, "cidade", "cep inválido") |> Map.put("estado", "cep inválido")
    end
  end
end
