defmodule Effects do

    def print(n) when n < 1 do
    end

    def print(n) do
        print(n-1)
        IO.puts(n)
    end

    def even_print(n) when n < 1 do
    end

    def even_print(n) do 
        even_print_aux(n, 2)
    end

    defp even_print_aux(n, n) do
        IO.puts(n)
    end

    defp even_print_aux(n, aux) when aux > n do
    end

    defp even_print_aux(n, aux) do
        IO.puts(aux)
        even_print_aux(n, aux + 2)
    end

end