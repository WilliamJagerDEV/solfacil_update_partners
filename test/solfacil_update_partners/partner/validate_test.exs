defmodule SolfacilUpdatePartners.Partner.ValidateTest do
  use ExUnit.Case
  alias SolfacilUpdatePartners.Repo
  doctest SolfacilUpdatePartners.Partner.Validate
  alias SolfacilUpdatePartners.Partner.Validate

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe("validate_partners/2") do
    test "when the params are valid, build and save the partners" do
      path_param = %{
        path:
          "C:/Users/willi/Documents/elixir/solfacil_update_partners/priv/test_files/partners.csv",
        filename: "partners.csv"
      }

      client_id_param = "2451549900013822061991"

      response = Validate.validate_partners(path_param, client_id_param)

      expected_response = [
        %{
          msg: "Um email de boas vindas foi enviado para atendimento@soleterno.com",
          partner_cnpj: "16.470.954/0001-06",
          status: "Email enviado"
        },
        %{
          msg: "Não foi possível enviar um email de boas vindas.",
          partner_cnpj: "19.478.819/0001-97",
          status: "Email não enviadoenviado"
        },
        %{
          msg: "Não foi possível enviar um email de boas vindas.",
          partner_cnpj: "12.473.742/0001-13",
          status: "Email não enviadoenviado"
        },
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

      assert response == expected_response
    end

    # test "When the email are invalid, returns and error logg." do
    #   param = %{
    #     "cep" => " 29090490",
    #     "cidade" => "Vitória",
    #     "client_id" => "2451549900013822061991",
    #     "cnpj" => "02.558.157/0001-62",
    #     "email" => " vivovivo",
    #     "estado" => "ES",
    #     "nome_fantasia" => " VIVO",
    #     "razao_social" => " Vivo LTDA",
    #     "telefone" => " 555555555"
    #   }

    #   response = SendEmail.check_email(param)

    #   expected_response = %{
    #     msg: "Não foi possível enviar um email de boas vindas.",
    #     partner_cnpj: "02.558.157/0001-62",
    #     status: "Email não enviadoenviado"
    #   }

    #   assert response == expected_response
    # end
  end
end
