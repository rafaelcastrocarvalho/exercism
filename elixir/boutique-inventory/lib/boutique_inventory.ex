defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: Enum.sort_by(inventory, & &1.price)

  def with_missing_price(inventory), do: Enum.filter(inventory, &is_nil(&1.price))

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      name = String.replace(item.name, old_word, new_word)
      %{item | name: name}
    end)
  end

  def increase_quantity(item, count) do
    quantities = Map.new(item.quantity_by_size, fn {k, v} -> {k, v + count} end)
    %{item | quantity_by_size: quantities}
  end

  def total_quantity(item) do
    item.quantity_by_size
    |> Enum.reduce(0, fn {_, v}, acc -> acc + v end)
  end
end
