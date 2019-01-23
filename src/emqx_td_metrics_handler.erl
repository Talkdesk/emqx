-module(emqx_td_metrics_handler).

-export([init/2]).
-import(statsd, [get_metrics/0]).

init(Req, State) ->
    Resp = cowboy_req:reply(200,
                            #{<<"content-type">> => <<"text/plain">>},
                            get_metrics(),
                            Req),
    {ok, Resp, State}.
