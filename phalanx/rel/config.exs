Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    default_release: :default,
    default_environment: Mix.env()


environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"dEKas1=9f3l<]yiAHTl!>U=my.`<*EbLAzB}RR^C4&0Yw($m/O)5>>DmCW?!:@,4"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"_X=.&/;jo(?W67)gt8a|g<5;N/:/x99cdABEuf7Xd11ah|$0Dr^<E)jGBkriSwFh"
end


release :phalanx do
  set version: current_version(:phalanx)
end

