defmodule ExsandTest do
  use ExUnit.Case
  doctest Exsand

  setup do
    {:ok, started1} = Application.ensure_all_started(:exsand)
    {:ok, started2} = Application.ensure_all_started(:ranch)
    {:ok, started2} = Application.ensure_all_started(:gun)
    {:ok, started3} = Application.ensure_all_started(:httpoison)
    {:ok, started4} = Application.ensure_all_started(:logger)
    IO.inspect started1
    IO.inspect started2
    :ok
  end

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "hello" do
    require Logger
    url = "http://localhost:8080/"
    response = HTTPoison.get!(url)
    Logger.info "レスポンス: #{inspect response}"
    assert "Hello" == response.body
  end

  test "redis" do
    url = "http://localhost:8080/redis/33"
    response1 = HTTPoison.get!(url)
    assert 404 == response1.status_code
    response2 = HTTPoison.post!(url, Poison.encode!(%{name: "spam"}))
    assert 200 == response2.status_code
    response3 = HTTPoison.get!(url)
    assert 200 == response3.status_code
    assert %{"name" => "spam"} == Poison.decode!(response3.body)
  end

  test "websocket" do
    {:ok, pid} = :gun.open('localhost', 8080)
    {:ok, :http} = :gun.await_up(pid)
    _mref = :gun.ws_upgrade(pid, "/ws")
    IO.puts "hoge1"
    receive do
      {:gun_ws_upgrade, ^pid, :ok, _headers} ->
        IO.puts "hoge2"
        IO.inspect _headers
        :ok = :gun.ws_send(pid, {:text, "count"})
        receive do
          {:gun_ws, ^pid, {:text, "10"}} ->
            :ok = :gun.ws_send(pid, {:text, "count"})
            receive do
              {:gun_ws, ^pid, {text, "11"}} ->
                :ok = :gun.ws_send(pid, {:text, "count"})
                receive do
                  {:gun_ws, ^pid, {text, "12"}} ->
                    :ok = :gun.ws_send(pid, {:text, "reset_count"})
                    receive do
                      {:gun_ws, pid, {:text, "0"}} ->
                        :ok
                    end
                end
            end
        end
    end
  end

end
