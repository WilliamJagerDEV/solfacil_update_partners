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

      expected_response = %{
        msg: "Um email de boas vindas foi enviado para  vivo@vivo",
        partner_cnpj: "02.558.157/0001-62",
        status: "Email enviado"
      }

      assert response == expected_response
    end

    test "when the CNPJ is invalid, returnas a error logg." do
      partner_param = %{
        " CEP" => " 29090490",
        "CNPJ" => "11839027789",
        "Email" => " vivo@vivo",
        "Nome Fantasia" => " VIVO",
        "Razão Social" => " Vivo LTDA",
        "Telefone" => " 555555555"
      }

      client_param = "2451549900013822061991"

      response = Build.build_partner(partner_param, client_param)

      expected_response = %{
              msg: "CNPJ não salvo por ser inválido",
              partner_cnpj: "11839027789",
              status: "Não salvo"
            }

      assert response == expected_response
    end
  end
end
