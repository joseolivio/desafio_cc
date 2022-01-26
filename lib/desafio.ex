defmodule Desafio do
  @doc """
  Sorts the passed data using the Quick sort algorithm.

  ## Examples
      iex> list = [1,2,3,5,5,6,7,7,5,3,2,1,2]
      iex> ApiTest.quick_sort(list)
      [1, 1, 2, 2, 2, 3, 3, 5, 5, 5, 6, 7, 7]
  """
  def quick_sort([]), do: []

  def quick_sort([h | t]) do
    {lesser, greater} = Enum.split_with(t, &(&1 < h))
    quick_sort(lesser) ++ [h] ++ quick_sort(greater)
  end

  @doc """
  Makes an HTTP GET Request to a specific single endpoint and returns the data, if avaiable.
  If the request fails to retrieve any data, it tries again one more time.

  ## Examples
      iex> {status, _data} = ApiTest.fetch_data_from_endpoint(1)
      iex> status
      :ok
  """
  def fetch_data_from_endpoint(page) do
    # Finch.start_link(name: MyFinch)
    case Finch.build(:get, "http://challenge.dienekes.com.br/api/numbers?page=#{page}")
         |> Finch.request(MyFinch) do
      {:ok, %Finch.Response{body: body}} ->
        {_status, body} = Jason.decode(body)
        numbers = Map.get(body, "numbers")

        if numbers do
          IO.puts(print_page(page))
          IO.puts(Enum.count(numbers))

          case Enum.count(numbers) do
            100 ->
              binary = (numbers ++ load_data()) |> :erlang.term_to_binary()
              File.write("data.txt", binary)
              {:ok, numbers}

            0 ->
              {:empty, []}
          end
        else
          # Try again...
          case Finch.build(:get, "http://challenge.dienekes.com.br/api/numbers?page=#{page}")
               |> Finch.request(MyFinch) do
            {:ok, %Finch.Response{body: body}} ->
              {_status, body} = Jason.decode(body)
              numbers = Map.get(body, "numbers")

              if numbers do
                IO.puts(print_page(page))
                IO.puts(Enum.count(numbers))

                case Enum.count(numbers) do
                  100 ->
                    binary = (numbers ++ load_data()) |> :erlang.term_to_binary()
                    File.write("data.txt", binary)
                    {:ok, numbers}

                  0 ->
                    {:empty, []}
                end
              else
                {:error, "an error occurred while trying to access page #{page}"}
              end

            {:error, msg} ->
              msg
          end
        end

      {:error, msg} ->
        msg
    end
  end

  defp print_page(page) do
    "Page: #{page}"
  end

  defp load_data() do
    case File.read("data.txt") do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, :enoent} -> []
    end
  end

  @doc """
  Loads the data from a local file (data.txt), applies quick sort and returns the sorted list.

  """
  def load_data_and_sort() do
    {:ok, binary} = File.read("data.txt")
    :erlang.binary_to_term(binary) |> quick_sort()
  end

  @doc """
  Navigates through the pages (from 1) fetching the data and storing it until it reaches the sample parameter
  or an empty value is returned, the content is stored in the data.txt file.
  """
  def extract_data(sample) do
    File.write("data.txt", :erlang.term_to_binary([]))
    {upper_limit, _} = Integer.parse(sample)

    Enum.reduce_while(1..upper_limit, 0, fn i, _acc ->
      case fetch_data_from_endpoint(i) do
        {:ok, numbers} -> {:cont, numbers}
        {:error, _numbers} -> {:cont, []}
        {:empty, _numbers} -> {:halt, []}
      end
    end)
  end

  def extract_data() do
    File.write("data.txt", :erlang.term_to_binary([]))

    Enum.reduce_while(1..100_000_000, 0, fn i, _acc ->
      case fetch_data_from_endpoint(i) do
        {:ok, numbers} -> {:cont, numbers}
        {:error, _numbers} -> {:cont, []}
        {:empty, _numbers} -> {:halt, []}
      end
    end)
  end
end
