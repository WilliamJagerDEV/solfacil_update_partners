defmodule SolfacilUpdatePartners.Partners do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  @fields [:nome_fantasia, :razao_social, :cnpj, :telefone, :cep, :cidade, :estado, :client_id]
  @derive {Jason.Encoder, only: @fields -- [:client_id]}

  schema "partners" do
    field :nome_fantasia, :string
    field :razao_social, :string
    field :cnpj, :string
    field :telefone, :string
    field :cep, :string
    field :cidade, :string
    field :estado, :string
    field :client_id, :string
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @fields)
  end
end
