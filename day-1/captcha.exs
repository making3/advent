defmodule Captcha do
    def check([head | tail]) do
        check([head] ++ tail ++ [head], 0)
    end
    def check(number) do
        number
        |> Integer.digits()
        |> check()
    end

    def check([], _), do: 0
    def check([head | tail], last) when head == last, do: head + check(tail, head)
    def check([head | tail], _), do: check(tail, head)
end

# Testers
# IO.puts Captcha.check(1122)
# IO.puts Captcha.check(1111)
# IO.puts Captcha.check(1234)
# IO.puts Captcha.check(91212129)

IO.gets("Enter captcha input: ")
|> String.slice(0..-2)
|> String.to_integer()
|> Captcha.check()
|> IO.puts
