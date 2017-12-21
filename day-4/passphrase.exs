defmodule Passphrase do
  def is_valid_simple(phrase) do
    words = String.split(phrase, " ")
    set = MapSet.new(words)
    MapSet.size(set) == length(words)
  end

  def is_valid_secure(phrase) do
    words = get_words(phrase)
    set = MapSet.new(words)
    MapSet.size(set) == length(words)
  end

  defp get_words(phrase) do
    words = phrase
    |> String.split(" ")
    |> Enum.map(&sort_word/1)
  end
  
  defp sort_word(word) do
    word
    |> String.to_charlist()
    |> Enum.sort()
    |> to_string()
  end

  def count(file, is_valid) do
    file
    |> File.open!()
    |> IO.stream(:line)
    |> Enum.reduce(0, fn(line, acc) ->
      line
      |> String.trim("\n")
      |> is_valid.()
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
#Passphrase.count('input', &Passphrase.is_valid_simple/1) |> IO.puts()


# Tests 2
#Passphrase.is_valid_secure("abcde fghij") |> IO.puts() # True
#Passphrase.is_valid_secure("a ab abc abd abf abj") |> IO.puts() # True
#Passphrase.is_valid_secure("iiii oiii ooii oooi oooo") |> IO.puts() # True
#IO.puts("")
#Passphrase.is_valid_secure("abcde xyz ecdab") |> IO.puts() # False
#Passphrase.is_valid_secure("oiii ioii iioi iiio") |> IO.puts() # False

# Part 2
Passphrase.count('input', &Passphrase.is_valid_secure/1) |> IO.puts()
