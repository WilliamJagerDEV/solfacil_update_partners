defmodule SolfacilUpdatePartnersWeb.Controllers.PartnersControllerTest do
  use ExUnit.Case
  alias SolfacilUpdatePartnersWeb.PartnersController

  describe("update_keys/1") do
    test "when the params are valid, fix the keys." do
      param = %{
        " CEP" => "29164815",
        "CNPJ" => "22783-115",
        "Email" => "atendimento@solenergia.com",
        "Nome Fantasia" => "Sol Energia LTDA",
        "Razão Social" => "Sol Energia",
        "Telefone" => ""
      }

      response = PartnersController.update_keys(param)

      expected_response = %{
        "cep" => "29164815",
        "cnpj" => "22783-115",
        "email" => "atendimento@solenergia.com",
        "nome_fantasia" => "Sol Energia LTDA",
        "razao_social" => "Sol Energia",
        "telefone" => ""
      }

      assert response == expected_response
    end

    # test "when the params are invalid, returns an error." do
    #   param = ["29164815", "22783-115", "atendimento@solenergia.com", "Sol Energia LTDA", "Sol Energia", "27996957945"]

    #   response = PartnersController.update_keys(param)

    #   expected_response = "banana"

    #   assert response == expected_response
    # end
  end
end
