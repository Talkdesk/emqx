-module(emqx_td_metrics_handler).

-export([init/2]).
-import(statsd, [get_metrics/0]).

init(Req, State) ->
    try get_metrics() of
        Metrics ->
            Resp = cowboy_req:reply(200,
                                    #{<<"content-type">> => <<"text/plain">>},
                                    Metrics,
                                    Req),
            {ok, Resp, State}
    catch
        _ ->
            io:format("Metrics requested but the plugin isn't been loaded yet."),
            Resp = cowboy_req:reply(502,
                                    #{<<"content-type">> => <<"text/plain">>},
                                    <<"Not ready.">>,
                                    Req),
            {ok, Resp, State}
    end.
