defmodule Mi6 do use GenServer
Code.require_file("../e2_creacion_de_listas/lib/create.ex")
Code.require_file("../e6_almacenamento_chave_valor/lib/db.ex")
Code.require_file("../e4_manipulacion_de_listas/lib/manipulating.ex")




  # Cliente API

  def fundar() do
    start_link()
  end

  defp start_link() do
    GenServer.start_link(__MODULE__, :ok, name: :mi6)
  end

  def recrutar(axente, destino) do
    GenServer.cast(:mi6, {:recrutar, axente, destino})
  end

  def asignar_mision(axente, mision) do
    GenServer.cast(:mi6, {:asignar_mision, axente, mision})
  end

  def consultar_estado(axente) do
    GenServer.call(:mi6, {:consultar_estado, axente})
  end

  def disolver() do
    GenServer.stop(:mi6)
  end

  def read(pid) do
    GenServer.call(pid, {:read})
  end

  defp add(pid, item) do
    GenServer.cast(pid, {:add, item})
  end


  #Callbacks servidor

  def init(:ok) do
    {:ok, Db.new()}
  end

  defp move_head([head | tail] = list) do
    tail ++ [head]
  end

  def handle_cast({:recrutar, axente, destino}, estado) do
    num = String.length(destino)
    lista = Enum.shuffle(Create.create(num))
    estado = Db.write(estado, axente, lista)
    estado = move_head(estado)
    {:noreply, estado}
  end

  def handle_call({:consultar_estado, axente}, from, estado) do
    lista_axente = Db.read(estado, axente)
    case lista_axente do
      {:error, :not_found} -> {:reply, :you_are_here_we_are_not, estado}
      {:ok, [h | t]} -> {:reply, [h | t], estado}
    end
  end

  def handle_cast({:asignar_mision, axente, :contrainformar}, estado) do
    lista_axente = Db.read(estado, axente)
    case lista_axente do
      {:ok, [h | t]} -> lista_axente = Manipulating.reverse([h | t])
              estado = Manipulating.reverse(Db.delete(estado, axente))
              estado = Db.write(estado, axente, lista_axente)
              estado = move_head(estado)
      {:noreply, estado}
      {:error, :not_found} -> {:noreply, estado}
    end
  end

  def handle_cast({:asignar_mision, axente, :espiar}, estado) do
    lista_axente = Db.read(estado, axente)
    case lista_axente do
      {:ok, [h | t]} -> lista_axente = Manipulating.filter([h | t], h)
              estado = Manipulating.reverse(Db.delete(estado, axente))
              estado = Db.write(estado, axente, lista_axente)
              estado = move_head(estado)
      {:noreply, estado}
      {:error, :not_found} -> {:noreply, estado}
    end
  end
end