-module(crypto_mock).

-export([encrypt/2]).

encrypt(Key, Data) when is_binary(Key) andalso is_binary(Data) ->
%%Key matters here, even though it’s not used.
timer:sleep(2000),
Data.