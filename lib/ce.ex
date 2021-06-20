defmodule MavuContent.Ce do
  @moduledoc """
  The Content-Element context.
  """

  defguard is_ce(term)
           when is_map(term) and
                  not is_nil(:erlang.map_get("ctype", term)) and
                  not is_nil(:erlang.map_get("uid", term))

  def create(ctype) when is_binary(ctype) do
    %{"ctype" => ctype, "uid" => create_uid()}
  end

  def duplicate_ce(ce) when is_ce(ce) do
    %{ce | "uid" => create_uid()} |> Map.put("_copy_of", ce["uid"])
  end

  def duplicate_ce(ce) do
    ce
  end

  def create_uid do
    Ecto.UUID.generate()
    |> String.replace("-", "_")
  end

  def stringify_keys(map) when is_map(map) do
    for {key, val} <- map, into: %{} do
      {to_string(key), val}
    end
  end

  def renew_uid(%{"uid" => _} = ce) when is_map(ce) do
    ce
    |> put_in(["uid"], create_uid())
  end

  def renew_uid(ce), do: ce
end
