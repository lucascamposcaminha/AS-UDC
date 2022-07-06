defmodule Echo do

    def start() do
        Process.register(spawn(fn -> echo() end), :echo)
        :ok
    end

    def stop() do
        send(:echo, :stop)
        Process.unregister(:echo)
        :ok
    end

    def print(term) do
        send(:echo, term)
        :ok
    end

    defp echo() do
        receive do
            :stop -> :stop
            msg -> IO.puts(msg) 
            echo()
        end
    end

end