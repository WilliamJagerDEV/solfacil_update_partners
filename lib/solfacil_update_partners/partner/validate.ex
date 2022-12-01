defmodule SolfacilUpdatePartners.Partner.Validate do
  alias alias SolfacilUpdatePartners.Partner.Build

  @doc """
  Função responsável por validar arquivo .csv e criar build caso seja.
  
  ## Examples
  
    iex> SolfacilUpdatePartners.Partner.Validate.validate_partners(
    iex(1)>  %{
    iex(2)>    path:
    iex(3)>    "C:/Users/willi/Documents/elixir/solfacil_update_partners/priv/test_files/partners.csv",
    iex(4)>    filename: "partners.csv"
    iex(5)>    },
    iex(6)>    "2451549900013822061991")
  
    [
      :ok,
      :ok,
      :ok,
      %{
        msg: "CNPJ não salvo por ser inválido",
        partner_cnpj: "214.004.920-92",
        status: "Não salvo"
      },
      %{
        msg: "CNPJ não salvo por ser inválido",
        partner_cnpj: "22783-115",
        status: "Não salvo"
      }
    ]
  
  """

  def validate_partners(file, client_id) do
    case check_file(file) do
      {:error, "Invalid file type"} ->
        %{status: "false", msg: "Invalid file type."}

      list ->
        list
        |> Enum.map(fn {:ok, partner} ->
          Build.build_partner(partner, client_id)
        end)
    end
  end

  defp check_file(file) do
    case String.contains?(file.filename, ".csv") do
      true ->
        get_csv(file)

      false ->
        {:error, "Invalid file type"}
    end
  end

  defp get_csv(file) do
    "#{file.path}"
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> CSV.decode(headers: true)
  end
end
