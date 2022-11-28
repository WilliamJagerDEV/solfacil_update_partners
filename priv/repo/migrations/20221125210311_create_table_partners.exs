defmodule SolfacilUpdatePartners.Repo.Migrations.CreateTablePartners do
  use Ecto.Migration

  def change do
    create table("partners") do
      add :nome_fantasia, :string
      add :razao_social, :string
      add :cnpj, :string
      add :telefone, :string
      add :cep, :string
      add :cidade, :string
      add :estado, :string
      add :client_id, :string

      # timestamps()
    end

    create unique_index(:partners, [:cnpj])
  end
end
