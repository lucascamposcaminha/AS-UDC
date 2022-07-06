defmodule Create do

    def create(0) do
        []
    end

    def create(n) when n < 0 do
        []
    end

    def create(n) do
        create_aux(n-1, [n])
    end

    defp create_aux(0, list) do
        list
    end

    defp create_aux(n, list) do
        create_aux(n-1, [n | list])
    end

    def reverse_create(0) do
        []
    end

    def reverse_create(n) when n < 0 do
        []
    end

    def reverse_create(1) do
        [1]
    end

    def reverse_create(n) do
        [n | reverse_create(n-1)]
    end

end