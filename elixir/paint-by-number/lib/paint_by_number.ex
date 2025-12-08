defmodule PaintByNumber do
  def palette_bit_size(0), do: 0
  def palette_bit_size(color_count), do: palette_bit_size(color_count, 1)

  defp palette_bit_size(color_count, power) do
    cond do
      color_count <= 2 ** power -> power
      true -> palette_bit_size(color_count, power + 1)
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bit_size = palette_bit_size(color_count)
    <<pixel_color_index::size(bit_size), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _), do: nil

  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<first_pixel::size(bit_size), _rest::bitstring>> = <<picture::bitstring>>
    first_pixel
  end

  def drop_first_pixel(<<>>, _color_count), do: <<>>

  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<_first_pixel::size(bit_size), rest::bitstring>> = <<picture::bitstring>>
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
