-module(emqx_td_metrics_handler).

-export([init/2]).
-import(statsd, [get_metrics/0]).
-define(METRICS_PLUGIN, statsd).

init(Req, State) ->
    case emqx_plugins:loaded(?METRICS_PLUGIN) of
        true ->
            Resp = cowboy_req:reply(200,
                                    #{<<"content-type">> => <<"text/plain">>},
                                    get_metrics(),
                                    Req),
            {ok, Resp, State};
        false ->
            Resp = cowboy_req:reply(503,
                                    #{<<"content-type">> => <<"text/plain">>},
                                    <<"Not ready yet.">>,
                                    Req),
            {ok, Resp, State}

    end.
