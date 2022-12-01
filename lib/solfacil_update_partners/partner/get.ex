defmodule SolfacilUpdatePartners.Partner.Get do
  import Ecto.Query
  alias SolfacilUpdatePartners.{Repo, Partners}

  @doc """
  Esta função busca todos os parceiros de um cliente por seu id (fictício: setado ao enviar arquivo .csv).
  
  ## Examples
  
    iex> SolfacilUpdatePartners.Partner.Get.get_by_client_id(%{"id" => "2451549900013822061991"})
  
    [
      %SolfacilUpdatePartners.Partners{
        __meta__: #Ecto.Schema.Metadata<:loaded, "partners">,
        id: 1,
        nome_fantasia: "Sol Eterno LTDA",
        razao_social: "Sol Amarelo",
        cnpj: "16.470.954/0001-06",
        telefone: "(21) 98207-9901",
        cep: "22783-115",
        cidade: "Rio de Janeiro",
        estado: "RJ",
        client_id: "2451549900013822061991"
      },
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
      },
      %SolfacilUpdatePartners.Partners{
        __meta__: #Ecto.Schema.Metadata<:loaded, "partners">,
        id: 3,
        nome_fantasia: "Sol Forte LTDA",
        razao_social: "Sol Forte",
        cnpj: "12.473.742/0001-13",
        telefone: "21982079903",
        cep: "84043-150",
        cidade: "Ponta Grossa",
        estado: "PR",
        client_id: "2451549900013822061991"
      }
    ]
  
  """

  def get_by_client_id(%{"id" => client_id}) do
    query =
      from(
        p in Partners,
        where: p.client_id == ^client_id,
        select: p
      )

    Repo.all(query)
  end
end
