defmodule SolfacilUpdatePartners.Partners do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  @fields [:nome_fantasia, :razao_social, :cnpj, :telefone, :cep, :cidade, :estado]
  @derive {Jason.Encoder, @fields}

  schema "partners" do
    field :nome_fantasia, :string
    field :razao_social, :string
    field :cnpj, :string
    field :telefone, :string
    field :cep, :string
    field :cidade, :string
    field :estado, :string
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @fields)
  end
end



