defmodule Checksum do
  def get(file) do
    File.open!(file)
    |> IO.stream(:line)
    |> Enum.reduce(0, &get_checksum/2)
  end

  defp get_checksum(line, acc) do
    line_checksum = line
    |> String.trim()
    |> String.split(["\t", " "])
    |> Enum.map(fn(x) -> String.to_integer(x) end)
    |> Enum.sort()
    |> calculate()
    
    acc + line_checksum
  end

  defp calculate(list) do
    Enum.max(list) - Enum.min(list)
  end
end

Checksum.get("input.txt") |> IO.puts()
