defmodule SolfacilUpdatePartners.Api.CheckCep do
  @url "viacep.com.br/ws/"

  # SolfacilUpdatePartners.Api.CheckCep.get_address("29164815")
  def get_address(cep) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(@url <> cep <> "/json")
    {:ok, address} = Jason.decode(body)
    address
  end
end
