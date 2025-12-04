defmodule Username do
  @allowed_chars ~c"abcdefghijklmnopqrstuvwxyz_äöüß"

  def sanitize(username) do
    username
    |> Enum.filter(&allowed_character?/1)
    |> Enum.flat_map(&sanitize_german/1)
  end

  defp allowed_character?(code_point), do: code_point in @allowed_chars

  defp sanitize_german(code_point) do
    case code_point do
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      _ -> [code_point]
    end
  end
end
