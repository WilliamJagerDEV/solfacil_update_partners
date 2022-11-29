defmodule SolfacilUpdatePartners.Partner.Save do
  alias SolfacilUpdatePartners.{Partners, Repo}

  @doc """
  Esta função salva os dados de um parceiro no banco ou os atualiza caso parceiro (cnpj) já exista.

  ## Examples

    iex> SolfacilUpdatePartners.Partner.Save.save_partner(
    iex(1)>  %{
    iex(2)>    "cep" => "84043-150",
    iex(3)>    "cidade" => "Ponta Grossa",
    iex(4)>    "client_id" => "2451549900013822061991",
    iex(5)>    "cnpj" => "12.473.742/0001-13",
    iex(6)>    "email" => "atendimentosolforte.com",
    iex(7)>    "estado" => "PR",
    iex(7)>    "nome_fantasia" => "Sol Forte LTDA",
    iex(8)>    "razao_social" => "Sol Forte",
    iex(9)>    "telefone" => "21982079903"
    iex(10)>  })

      %{
        "cep" => "84043-150",
        "cidade" => "Ponta Grossa",
        "client_id" => "2451549900013822061991",
        "cnpj" => "12.473.742/0001-13",
        "email" => "atendimentosolforte.com",
        "estado" => "PR",
        "nome_fantasia" => "Sol Forte LTDA",
        "razao_social" => "Sol Forte",
        "telefone" => "21982079903"
      }

  """

  def save_partner(partner) do
    Partners.changeset(partner)
    |> Repo.insert(
      on_conflict: [set: [razao_social: partner["razao_social"]]],
      conflict_target: [:cnpj]
    )
  end

end
