defmodule SolfacilUpdatePartners.Api.CheckCepTest do
  use ExUnit.Case
  doctest SolfacilUpdatePartners.Api.CheckCep
  alias SolfacilUpdatePartners.Api.CheckCep

  describe("get_address/1") do
    test "when the param is valid, returns the locale response." do
      param = "29164815"
      response = CheckCep.get_address(param)

      expected_response =
        {:ok,
         %{
           "bairro" => "Bicanga",
           "cep" => "29164-815",
           "complemento" => "",
           "ddd" => "27",
           "gia" => "",
           "ibge" => "3205002",
           "localidade" => "Serra",
           "logradouro" => "Rua Guanabara",
           "siafi" => "5699",
           "uf" => "ES"
         }}

      assert response == expected_response
    end

    test "when the param is invalid, returns an error." do
      cep = "123456789"
      response = CheckCep.get_address(cep)

      expected_response = {:error, "Invalid CEP"}

      assert response == expected_response
    end
  end
end
