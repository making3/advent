defmodule Passphrase do
  def is_valid(phrase) do
    words = String.split(phrase, " ")
    set = MapSet.new(words)
    MapSet.size(set) == length(words)
  end

  def count(file) do
    file
    |> File.open!()
    |> IO.stream(:line)
    |> Enum.reduce(0, fn(line, acc) ->
      line
      |> String.trim("\n")
      |> is_valid()
      |> reduce(acc)
    end)
  end

  defp reduce(false, acc), do: acc
  defp reduce(true, acc), do: acc + 1
end

# Tests
#Passphrase.is_valid("aa bb cc dd ee") |> IO.puts()
#Passphrase.is_valid("aa bb cc dd aa") |> IO.puts()
#Passphrase.is_valid("aa bb cc dd aaa") |> IO.puts()

# Part 1
Passphrase.count('input') |> IO.puts()
