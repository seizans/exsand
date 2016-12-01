use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: :dev


environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"6cwA1WM]xwPQ)`ZO/w_^~v{_P7sjyXu0(!+QlPQAfWVp!eAA@_K_-;4w!7+jRHT+"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"6cwA1WM]xwPQ)`ZO/w_^~v{_P7sjyXu0(!+QlPQAfWVp!eAA@_K_-;4w!7+jRHT+"
end


release :cow do
  set version: current_version(:cow)
end
