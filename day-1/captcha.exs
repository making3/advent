defmodule Captcha do
    def to_array(number) do
        number
        |> Integer.digits()
    end

    def check([head | tail]) do
        check([head] ++ tail ++ [head], 0)
    end

    def check([], _), do: 0
    def check([head | tail], last) when head == last, do: head + check(tail, head)
    def check([head | tail], _), do: check(tail, head)

    def check_half(array) do
        array_half = div length(array), 2
        [first_chunk | _] = Enum.chunk(array, array_half)
        check_half(array ++ first_chunk, array_half, 0)
    end

    def check_half(array, array_half, acc) when array_half > length(array) do
        acc
    end
    def check_half([head | tail], array_half, acc) do
        if head == Enum.at(tail, array_half - 1) do
            head + check_half(tail, array_half, acc)
        else
            check_half(tail, array_half, acc)
        end
    end
end

# Testers
# IO.puts Captcha.check(1122)
# IO.puts Captcha.check(1111)
# IO.puts Captcha.check(1234)
# IO.puts Captcha.check(91212129)

IO.gets("Enter captcha input: ")
|> String.slice(0..-2)
|> String.to_integer()
|> Captcha.to_array()
# |> Captcha.check()
|> Captcha.check_half()
|> IO.puts
