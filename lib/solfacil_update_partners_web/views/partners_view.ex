defmodule SolfacilUpdatePartnersWeb.PartnersView do
  use SolfacilUpdatePartnersWeb, :view

  def render("index.json", %{partners: partners}) do
    each_partner(partners)
  end

  defp each_partner(partners) do
    Enum.map(partners, fn partner -> partner end)
  end
end
