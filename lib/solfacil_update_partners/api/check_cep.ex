defmodule SolfacilUpdatePartners.Api.CheckCep do
  @url "viacep.com.br/ws/"

  def get_address(cep) do
    cep = cep |> String.replace([",", "-", ".", "_"], "")
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get("viacep.com.br/ws/" <> cep <> "/json")
    {:ok, address} = Jason.decode(body)
    address
  end
end
