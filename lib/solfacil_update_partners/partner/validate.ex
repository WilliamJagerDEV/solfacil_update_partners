defmodule SolfacilUpdatePartners.Partner.Validate do
  alias alias SolfacilUpdatePartners.Partner.Build
  alias SolfacilUpdatePartners.Partner.Csv

  def validate_partners(file, client_id) do
    case Csv.check_file(file) do
      {:error, "Invalid file type"} ->
        %{status: "false", msg: "Invalid file type."}

      list ->
        list
        |> Enum.map(fn {:ok, partner} ->
          Build.build_partner(partner, client_id)
        end)
    end
  end
end
