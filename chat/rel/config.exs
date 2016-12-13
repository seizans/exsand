use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: :dev


environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"M5!-F`:MeRe`&Vn$Lb)3olYti.bNmvHA(m:@=K7``0v)~6}i^&7J$b)%SF[9b{@G"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"M5!-F`:MeRe`&Vn$Lb)3olYti.bNmvHA(m:@=K7``0v)~6}i^&7J$b)%SF[9b{@G"
end


release :chat do
  set version: current_version(:chat)
end

