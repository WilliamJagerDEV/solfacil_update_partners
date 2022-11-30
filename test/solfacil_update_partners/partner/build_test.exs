defmodule SolfacilUpdatePartners.Partner.BuildTest do
  # use ExUnit.Case
  use SolfacilUpdatePartners.DataCase

  doctest SolfacilUpdatePartners.Partner.Build
  alias SolfacilUpdatePartners.Partner.Build

  describe("build_partner/2") do
    test "when the param is valid, build and save the partner." do
      partner_param = %{
        " CEP" => " 29090490",
        "CNPJ" => "02.558.157/0001-62",
        "Email" => " vivo@vivo",
        "Nome Fantasia" => " VIVO",
        "Razão Social" => " Vivo LTDA",
        "Telefone" => " 555555555"
      }

      client_param = "2451549900013822061991"

      response = Build.build_partner(partner_param, client_param)

      expected_response = "banana"

      assert response == expected_response
    end
  end
end
