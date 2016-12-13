defmodule Chat.Room do
  use GenServer

  def add_message(message) do
    GenServer.cast(:chat_room, {:add_message, message})
  end

  def get_messages() do
    GenServer.call(:chat_room, :get_messages)
  end


  def start_link() do
    GenServer.start_link(__MODULE__, [], [name: :chat_room])
  end

  def init([]) do
    {:ok, []}
  end

  def handle_call(:get_messages, _from, messages) do
    {:reply, messages, messages}
  end

  def handle_cast({:add_message, message}, messages) do
    {:noreply, [message | messages]}
  end
end
