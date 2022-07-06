defmodule Sorting do

    def quicksort([]) do
        []
    end

    def quicksort([pivot | tail]) do
        {lower, higher} = Enum.partition(tail, &(&1 < pivot))
        concatenacion = concatenate(quicksort(lower), [pivot])
        concatenacion_final = concatenate(concatenacion, quicksort(higher))
    end

    def mergesort([]) do
        []
    end

    def mergesort([head| []]) do
        [head]
    end

    def mergesort(list) do
        {lower, higher} = Enum.split(list, div(length(list),2))
        merge(mergesort(lower), mergesort(higher), [])
    end


    defp merge([], higher, list) do
        concatenate(Enum.reverse(list), higher)
    end

    defp merge(lower, [], list) do
        concatenate(Enum.reverse(list), lower)
    end

    defp merge([lower_h | lower_t], [higher_h | higher_t], list) when lower_h <= higher_h do
        merge(lower_t, [higher_h | higher_t], [lower_h | list])
    end

    defp merge([lower_h | lower_t], [higher_h | higher_t], list) when lower_h > higher_h do
        merge([lower_h | lower_t], higher_t, [higher_h | list])
    end

    defp concatenate([], list) do
        list
    end
    
    defp concatenate([head | tail], list) do
        [head | concatenate(tail, list)]
    end

end