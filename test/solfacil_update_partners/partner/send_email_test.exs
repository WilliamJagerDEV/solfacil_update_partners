defmodule SolfacilUpdatePartners.Partner.SendEmailTest do
  use ExUnit.Case
  doctest SolfacilUpdatePartners.Partner.SendEmail
  alias SolfacilUpdatePartners.Partner.SendEmail

  describe("check_email/1") do
    test "When the email are valid, send a welcome mail to the partner." do
      param = %{
        "cep" => " 29090490",
        "cidade" => "Vitória",
        "client_id" => "2451549900013822061991",
        "cnpj" => "02.558.157/0001-62",
        "email" => " vivo@vivo",
        "estado" => "ES",
        "nome_fantasia" => " VIVO",
        "razao_social" => " Vivo LTDA",
        "telefone" => " 555555555"
      }

      response = SendEmail.check_email(param)

      expected_response = %{
        msg: "Um email de boas vindas foi enviado para  vivo@vivo",
        partner_cnpj: "02.558.157/0001-62",
        status: "Email enviado"
      }

      assert response == expected_response
    end

    test "When the email are invalid, returns and error logg." do
      param = %{
        "cep" => " 29090490",
        "cidade" => "Vitória",
        "client_id" => "2451549900013822061991",
        "cnpj" => "02.558.157/0001-62",
        "email" => " vivovivo",
        "estado" => "ES",
        "nome_fantasia" => " VIVO",
        "razao_social" => " Vivo LTDA",
        "telefone" => " 555555555"
      }

      response = SendEmail.check_email(param)

      expected_response = %{
        msg: "Não foi possível enviar um email de boas vindas.",
        partner_cnpj: "02.558.157/0001-62",
        status: "Email não enviadoenviado"
      }

      assert response == expected_response
    end
  end
end
