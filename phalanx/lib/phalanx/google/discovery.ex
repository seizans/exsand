defmodule Phalanx.Google.Discovery do
  # See http://openid.net/specs/openid-connect-discovery-1_0.html
  require Logger
  @discovery_document_uri %URI{scheme: "https",
                               host: "accounts.google.com",
                               path: "/.well-known/openid-configuration"}

  # TODO(seizans): keys を jwks_uri から max-age ごとに更新する

  defmodule State do
    defstruct [:authorization_endpoint, :jwks_uri, :token_endpoint]
  end

  def authorization_endpoint() do
    Agent.get(__MODULE__, fn(state) -> state.authorization_endpoint end)
  end

  def jwks_uri() do
    Agent.get(__MODULE__, fn(state) -> state.jwks_uri end)
  end

  def token_endpoint() do
    Agent.get(__MODULE__, fn(state) -> state.token_endpoint end)
  end

  def update_cache() do
    Agent.update(__MODULE__, fn(%State{} = _state) -> init() end)
  end


  def start_link() do
    Agent.start_link(fn -> init() end, name: __MODULE__)
  end

  defp init() do
    %HTTPoison.Response{status_code: 200,
                        headers: headers,
                        body: body} = HTTPoison.get!(@discovery_document_uri)
    {"cache-control", "public, max-age=" <> max_age} = headers
                                                       |> Enum.map(fn({k, v}) -> {String.downcase(k), v} end)
                                                       |> List.keyfind("cache-control", 0)
    time_in_milliseconds = String.to_integer(max_age) * 1000
    :timer.apply_after(time_in_milliseconds, __MODULE__, :update_cache, [])
    Logger.info("GOT DISCOVERY DOCUMENT | #{body}")
    Poison.decode!(body, as: %State{})
  end
end
