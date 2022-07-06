defmodule Ring do   

    def start(n, m, msg) when n < 1 do
    end

    def start(n, m, msg) when m < 1 do
    end

    def start(n, m, msg) do
        pid = spawn(__MODULE__, :process, [1, n, m, msg, self()])
        Process.register(pid, :ring)
        :ok
    end

    def process(1, n, m, msg, initial_pid) do
        pid = spawn(__MODULE__, :process, [2, n, m-1, msg, self()])
        send(pid, {m - 1, msg})
        message(pid)
    end

    def process(i, n, _, _, initial_pid) when i != n do
        pid = spawn(__MODULE__, :process, [i+1, n, 1, 1, initial_pid])
        message(pid)
    end

    def process(i, n, _, _, initial_pid) do
        message(initial_pid)
    end

    def message(pid) do
        receive do
            :stop -> send(pid, :stop)
                        :stop
            {0, _} -> send(pid, :stop)
                      exit(:normal)
            {m, msg} -> send(pid, {m-1, msg})
                        message(pid)
        end
    end
end