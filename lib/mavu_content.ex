defmodule MavuContent do
  @moduledoc false

  def conf(local_conf \\ %{}) do
    %{app_module: MyApp, be_module: MyAppBe, web_module: MyAppWeb}
    |> Map.merge(local_conf)
  end
end
