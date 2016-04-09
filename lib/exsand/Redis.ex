defmodule Exsand.Redis do
  @pool_name :exsand_redis_pool

  @default_expire 86400

  @pool_size 32
  @max_overflow 0

  @default_host '127.0.0.1'
  @default_port 6379
  @default_db 0

  def set(id, name) do
    expire = @default_expire
    {:ok, "OK"} = q(['SET', id, name, 'EX', expire])
    :ok
  end

  def get(id) do
    case q(['GET', id]) do
      {:ok, :undefined} ->
        :not_found
      {:ok, name} ->
        IO.inspect name
        name
    end
  end

  defp q(command, timeout \\ 5000) do
    :poolboy.transaction @pool_name,
                         fn(worker) -> :eredis.q(worker, command, timeout) end
  end

  @spec child_spec() :: :supervisor.child_spec()
  def child_spec() do
    pool_size = @pool_size
    max_overflow = @max_overflow
    pool_args = [size: pool_size,
                 max_overflow: max_overflow,
                 name: {:local, @pool_name},
                 worker_module: :eredis]

    host = @default_host
    port = @default_port
    db = @default_db
    worker_args = [host: host,
                   port: port,
                   database: db]

    :poolboy.child_spec(@pool_name, pool_args, worker_args)
  end

end
