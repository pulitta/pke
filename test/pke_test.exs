defmodule PkeTest do
    use ExUnit.Case
    doctest Pke

    setup do
        Application.delete_env(:pke, :key_path, [])
        Application.delete_env(:pke, :crypto_module, [])
    end

    test "No data args in command line" do
        Application.put_env(:pke, :key_path, "test/key.pub", [])
        Application.put_env(:pke, :crypto_module, :crypto_mock, [])
        result = Pke.main([])
        assert nil == result
    end

    test "No key_path in config" do
        result = Pke.main(["--data", "123"])
        assert nil == result
    end

    test "No crypto module in config" do
        Application.put_env(:pke, :key_path, "test/key.pub", [])
        result = Pke.main(["--data", "123"])
        assert nil == result
    end

    test "No key file" do
        Application.put_env(:pke, :key_path, "test.pub", [])
        result = Pke.main(["--data", <<"123">>])
        assert nil == result
    end

    test "Success" do
        Application.put_env(:pke, :key_path, "test/key.pub", [])
        Application.put_env(:pke, :crypto_module, :crypto_mock, [])
        result = Pke.main(["--data", "123"])
        assert :ok == result
    end
end
