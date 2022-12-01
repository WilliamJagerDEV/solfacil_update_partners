defmodule Temp do
  def test do

      SolfacilUpdatePartners.Partner.Validate.validate_partners(
        %{
          path:
            "C:/Users/willi/Documents/elixir/solfacil_update_partners/priv/test_files/partners.csv",
          filename: "partners.csv"
        },
        "2451549900013822061991"
      )
  end
end
