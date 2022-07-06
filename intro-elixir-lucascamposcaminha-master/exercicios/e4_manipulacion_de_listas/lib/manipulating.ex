defmodule Manipulating do

    def filter([head | tail],n) when head > n do
         filter(tail, n)
    end

    def filter([head | tail],n) do
        [head | filter(tail,n)]
    end

    def filter([],_) do
        []
    end

    def reverse(list) do
        reverse_aux(list,[])
    end

    defp reverse_aux([head | tail], lista) do
        reverse_aux(tail, [head | lista])
    end

    defp reverse_aux([], lista) do
        lista
    end

    def concatenate([head | tail]) do
        concatenate_aux(head, concatenate(tail))
    end

    def concatenate([]) do
        []
    end

    defp concatenate_aux([], list) do
        list
    end
    
    defp concatenate_aux([head | tail], list) do
        [head | concatenate_aux(tail, list)]
    end

    def flatten(list) do
        flatten_aux(list, [])
    end

    defp flatten_aux([head | tail], lista) when head == [] do
        flatten_aux(tail, lista)
    end

    defp flatten_aux([head | tail], lista) when (is_list(head)) do
        flatten_aux(head, flatten_aux(tail, lista))
    end
    
    defp flatten_aux([head | tail], lista) do
        [head | flatten_aux(tail, lista)]
    end

    defp flatten_aux([], lista) do
        lista
    end

end