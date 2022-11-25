defmodule SolfacilUpdatePartners.Api.CheckCep do
  @url "viacep.com.br/ws/"

  def get_address(cep) do
    IO.inspect(cep, label: "CEP")

    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(@url <> cep <> "/json")
    {:ok, address} = Jason.decode(body)
    address
  end
end
