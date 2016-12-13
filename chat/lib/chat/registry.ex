defmodule Chat.Registry do
  use GenServer

  def whereis_name(room_name) do
    GenServer.call(:registry, {:whereis_name, room_name})
  end

  def register_name(room_name, pid) do
    GenServer.call(:registry, {:register_name, room_name, pid})
  end

  def unregister_name(room_name) do
    GenServer.cast(:registry, {:unregister_name, room_name})
  end

  def send(room_name, message) do
    case whereis_name(room_name) do
      nil ->
        {:bad_arg, {room_name, message}}
      pid ->
        Kernel.send(pid, message)
        pid
    end
  end


  def start_link() do
    GenServer.start_link(__MODULE__, :ok, [name: :registry])
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:whereis_name, room_name}, _from, state) do
    {:reply, Map.get(state, room_name), state}
  end
  def handle_call({:register_name, room_name, pid}, _from, state) do
    case Map.get(state, room_name) do
      nil ->
        {:reply, :yes, Map.put(state, room_name, pid)}
      _ ->
        {:reply, :no, state}
    end
  end

  def handle_cast({:unregister_name, room_name}, state) do
    {:noreply, Map.delete(state, room_name)}
  end

end
