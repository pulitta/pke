use Mix.Config

config :pke, 
key_path: "test/key.pub",		# <- Public key path
crypto_module: :crypto_mock		# <- Crypto module name

