use Mix.Config

config :pke, 
key_path: "test/ke.pub",		# <- Public key path
crypto_module: :crypto_mock		# <- Crypto module name

