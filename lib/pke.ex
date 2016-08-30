defmodule Pke do

	@moduledoc """
	Provides public key encryption functionality.
	"""
	# Main function
	def main(args) do
		data = args |> parse_args |> get_data
		{get_key, data, get_crypto_module} |> handle_encrypt_input |> encrypt
  	end

  	# Get public key from config
  	defp get_key() do
  		case Application.get_env(:pke, :key_path) do
			nil 		-> {:error, :bad_key_path}
			key_path 	->
				case File.read(key_path) do
					{:ok, key} 	-> key
					other 		-> other
				end
		end 
  	end

  	# Get data from command line
  	defp get_data(:help) do
  		{:error, :help}
  	end

  	defp get_data(options) do
  		data = options[:data]
  		case data do
  			nil -> {:error, :help}
  			_ 	-> data
  		end
  	end

  	# Get crypto module name from config
  	defp get_crypto_module() do
  		case Application.get_env(:pke, :crypto_module) do
  			nil 			-> {:error, :bad_crypto_module}
			crypto_module 	-> crypto_module
		end
	end

	# Handle errors before call of encrypt 
	defp handle_encrypt_input(input) do
		handle_error = fn 
			:bad_key_path 		-> IO.puts "Key path is not configured"
			:bad_crypto_module 	-> IO.puts "Crypto module is not configured"
			:help 				-> IO.puts "No data. Usage: pke --data=<some data>" 
			other 				-> IO.puts "Read file error: #{other}"

		end
		case input do
			{{:error, reason}, _, _} -> handle_error.(reason)
			{_, {:error, reason}, _} -> handle_error.(reason)
			{_, _, {:error, reason}} -> handle_error.(reason)
			other -> other
		end
	end

	# If errors found - do nothing
	defp encrypt(:ok) do 
		nil
	end

	# If no errors - call erlang function 'encrypt' from crypto_module
  	defp encrypt({key, data, crypto_module}) do
  		encrypted_data = crypto_module.encrypt(key,data)
    	IO.puts "#{encrypted_data}"
  	end

  	# Parse command line args
  	defp parse_args([]) do
    	:help
  	end

  	defp parse_args(args) do
    	case OptionParser.parse(args, switches: [data: :string]) do
    		{options, _, _} -> options
    		_               -> :help
    	end
	end
end
