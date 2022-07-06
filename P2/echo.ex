defmodule Echo do
  def start_server(n) do
    IO.puts("\nStarting echo server\n")

    pid = spawn(fn -> start() end)
    Process.register(pid, :start)

    pid_creation = spawn(fn -> creation() end)
    Process.register(pid_creation, :creation)

    pid_action = spawn(fn -> action() end)
    Process.register(pid_action, :action)

    pid_print = spawn(fn -> print() end)
    Process.register(pid_print, :print)

    send(:start, {n,n})
  end

  defp start() do
    receive do
      {n,m} -> start_aux(n,m)
    end
  end

  defp start_aux(n,m) when n==1 do
    send(:creation, {1,m})
  end

  defp start_aux(n,m) do
    send(:creation, {n,m})
    send(:start, {n-1,m})
    start()
  end

  defp creation() do
    receive do
      {n,m} -> creation_aux(n,m)
    end
  end

  defp creation_aux(n,m) when n==1 do
    msg = "Phrase number #{inspect(m)}"
    send(:action, {msg,:end})
  end

  defp creation_aux(n,m) do
    msg = "Phrase number #{inspect(m-n+1)}"
    send(:action, msg)
    creation()
  end

  defp action() do
    receive do
      {msg, :end} -> msg_aux = String.length(msg)
                     msg_print = "#{msg} has #{msg_aux} characters"
                     send(:print, {msg_print, :end})
      msg -> msg_aux = String.length(msg)
             msg_print = "#{msg} has #{msg_aux} characters"
             send(:print, msg_print)
             action()
    end
  end

  defp print() do
    receive do
      {msg, :end} -> IO.puts(msg)
                     IO.puts("\nServer echo finished")
                     :ok
      msg -> IO.puts(msg)
             print()
    end
  end

end

Echo.start_server(10)