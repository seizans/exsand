use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: :dev


environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"bC+t+l|`6PoILi~,lfnR%xi|(Jl*lQwNOsS7FUzQD`+7h,5nklqoaM8xwzwC)0R&"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"bC+t+l|`6PoILi~,lfnR%xi|(Jl*lQwNOsS7FUzQD`+7h,5nklqoaM8xwzwC)0R&"
end


release :ran do
  set version: current_version(:ran)
end

