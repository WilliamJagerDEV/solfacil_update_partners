defmodule SolfacilUpdatePartners.Partner.Build do
  alias SolfacilUpdatePartners.Api.CheckCep
  alias SolfacilUpdatePartners.Partner.Save
  alias SolfacilUpdatePartners.{Partners, Repo}
  alias SolfacilUpdatePartners.Partner.SendEmail
  require Logger

  @doc """
  Caso númeor de cnpj esteja no padrão, esta função valida os dados um parceiro antes que sejam salvos, formatando key_words e inserindo cidade e estado caso cep esteja válido.
  
  ## Examples
  
    iex> SolfacilUpdatePartners.Partner.Build.build_partner(
    iex(1)>  %{
    iex(2)>    " CEP" => "1234",
    iex(3)>    "CNPJ" => "19.478.819/0001-97",
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

  # SolfacilUpdatePartners.Partner.Validate.build_partner("118.390.277-89")
  # SolfacilUpdatePartners.Partner.Validate.build_partner("19.478.819/0001-97")
  # SolfacilUpdatePartners.Partner.Validate.build_partner("24.410.913/0001-44")

  # ------------------
  # nubank
  # 24.410.913/0001-44
  # 999999999
  # nil
  # ------------------
  # Sol Amarelo
  # 16.470.954/0001-06
  # ------------------
  # Sol da manha
  # 19.478.819/0001-97
  # ------------------
  # sol forte
  # 12.473.742/0001-13
  # ------------------

  def build_partner(partner, client_id) do
    partner = update_partner_map(partner, client_id)

    with true <- Cpfcnpj.valid?({:cnpj, partner["cnpj"]}),
         :cnpj_not_exists <- check_partner(partner["cnpj"]) do
      IO.inspect(partner, label: "XXXXXXXXXX NÃO EXISTE XXXXXXXXXX")
      Save.save_partner(partner)

      Logger.info(%{
        partner_cnpj: partner["cnpj"],
        status: "Salvo",
        msg: "CNPJ salvo e email enviado."
      })

      SendEmail.check_email(partner)
    else
      false ->
        Logger.info(%{
          partner_cnpj: partner["cnpj"],
          status: "Não salvo",
          msg: "CNPJ não salvo por ser inválido"
        })

      :cnpj_exists ->
        IO.inspect(partner, label: "XXXXXXXXXX EXISTE XXXXXXXXXX")
        Save.save_partner(partner)

        Logger.info(%{partner_cnpj: partner["cnpj"], status: "Atualizado", msg: "CNPJ atualizado"})
    end
  end

  defp check_partner(cnpj) do
    case Repo.get_by(Partners, cnpj: cnpj) do
      nil -> :cnpj_not_exists
      _var -> :cnpj_exists
    end
  end

  defp update_partner_map(partner, client_id) do
    partner
    |> update_keys()
    |> update_locale(client_id)
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

  defp update_locale(partner, client_id) do
    case CheckCep.get_address(partner["cep"]) do
      {:ok, %{"localidade" => cidade, "uf" => estado}} ->
        new_map =
          Map.put(partner, "cidade", cidade)
          |> Map.put("estado", estado)
          |> Map.put("client_id", client_id)

        Logger.info("Cidade e Estado encontrado a partir do CEP informado.")
        new_map

      {:error, _error} ->
        new_map =
          partner
          |> Map.delete("cep")
          |> Map.put("client_id", client_id)

        Logger.info("CEP apagado do parceiro por estar inválido ou sem retorno.")
        new_map
    end
  end
end
