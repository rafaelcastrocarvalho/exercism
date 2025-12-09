defmodule DNA do
  @nucleotide_codes [{?\s, 0}, {?A, 1}, {?C, 2}, {?G, 4}, {?T, 8}]

  def encode_nucleotide(nucleotide), do: do_encode_nucleotide(nucleotide, @nucleotide_codes)

  def decode_nucleotide(encoded_code) do
    do_decode_nucleotide(encoded_code, @nucleotide_codes)
  end

  def encode(dna), do: do_encode(dna, <<>>)

  def decode(encoded_dna), do: do_decode(encoded_dna, ~c"")

  defp do_encode_nucleotide(nucleotide, [{nucleotide, code} | _tail]), do: code

  defp do_encode_nucleotide(nucleotide, [_head | tail]) do
    do_encode_nucleotide(nucleotide, tail)
  end

  defp do_decode_nucleotide(encoded_code, [{nucleotide, encoded_code} | _tail]), do: nucleotide

  defp do_decode_nucleotide(encoded_code, [_head | tail]) do
    do_decode_nucleotide(encoded_code, tail)
  end

  defp do_encode([], encoded_dna), do: encoded_dna

  defp do_encode([nucleotide | dna], encoded_dna) do
    encoded_nucleotide = encode_nucleotide(nucleotide)
    do_encode(dna, <<encoded_dna::bitstring, encoded_nucleotide::size(4)>>)
  end

  defp do_decode(<<>>, dna), do: dna

  defp do_decode(<<encoded_nucleotide::4, encoded_dna::bitstring>>, dna) do
    decoded_nucleotide = decode_nucleotide(encoded_nucleotide)
    do_decode(encoded_dna, dna ++ [decoded_nucleotide])
  end
end
