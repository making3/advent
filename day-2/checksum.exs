defmodule Checksum do
  def get(file, calculate) do
    File.open!(file)
    |> IO.stream(:line)
    |> Enum.reduce(0, fn(line, acc) ->
      acc + get_checksum(line, calculate)
    end)
  end

  defp get_checksum(line, calculate) do
    line
    |> String.trim()
    |> String.split(["\t", " "])
    |> Enum.map(fn(x) -> String.to_integer(x) end)
    |> Enum.sort()
    |> calculate.()
  end
end

defmodule PartOne do
  def calculate(list) do
    Enum.max(list) - Enum.min(list)
  end
end

defmodule PartTwo do
  def calculate([]) do
    0
  end
  def calculate([head | tail]) do
    case check(head, Enum.reverse(tail)) do
      {:ok, result} ->
        result
      {:no} ->
        calculate(tail)
    end
  end

  defp check(_, []) do
    {:no}
  end
  defp check(low, [head | _]) when (rem head, low) == 0 do
    {:ok, (div head, low)}
  end
  defp check(low, [_ | tail]) do
    check(low, tail)
  end
end

#Checksum.get("input.txt", &PartOne.calculate/1) |> IO.puts()
Checksum.get("input2.txt", &PartTwo.calculate/1) |> IO.puts()
