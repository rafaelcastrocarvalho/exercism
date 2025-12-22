defmodule BasketballWebsite do
  require IEx

  def extract_from_path(data, path) do
    keys = String.split(path, ".")

    Enum.reduce_while(keys, data, fn
      _, nil -> {:halt, nil}
      key, data -> {:cont, data[key]}
    end)
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
