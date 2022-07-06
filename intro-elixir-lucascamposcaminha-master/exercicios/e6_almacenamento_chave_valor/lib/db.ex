defmodule Db do

  defp concatenate([], list) do
    list
  end

  defp concatenate([head | tail], list) do
    [head | concatenate(tail, list)]
  end

  def new() do
      []
  end

  def write([], key, element) do
      [{key, element}]
  end

  def write([{key,_} | tl], key, element) do
      [{key, element} | tl]
  end

  def write([hd | tl], key, element) do
    write_aux([hd], tl, key, element)
  end

  defp write_aux(checked, [], key, element) do
      concatenate(checked, [{key, element}])
  end

  defp write_aux(checked, [{key,_} | tl], key, element) do
      concatenacion = concatenate(checked, [{key, element}])
      concatenacion_final = concatenate(concatenacion, [tl])
  end

  defp write_aux(checked, [hd | tl], key, element) do
      write_aux(concatenate(checked, [hd | tl]), tl, key, element)
  end

  def delete([], key) do
      []
  end

  def delete([{key,_} | tl], key) do
    tl
  end

  def delete([hd | tl], key) do
    delete_aux([hd], tl, key)
  end

  defp delete_aux(checked, [], key) do
      checked      
  end

  defp delete_aux(checked, [{key,_} | tl], key) do
    concatenate(checked, tl)
  end

  defp delete_aux(checked, [hd | tl], key) do
    delete_aux(concatenate(checked, [hd]), tl, key)
  end

  def read([], key) do
      {:error, :not_found}
  end

  def read([{key,_} = hd | tl], key) do
     {:ok, hd |> elem(1)}
  end

  def read([hd | tl], key) do
    read_aux(tl, key)
  end
    
  defp read_aux([], key) do
      {:error, :not_found}
  end

  defp read_aux([{key,_} = hd | tl], key) do
    {:ok, hd |> elem(1)}
  end

  defp read_aux([hd | tl], key) do
    read_aux(tl, key)
  end

  def match([], element) do
    []
  end

  def match([{_, element}  = hd | tl], element) do
      match_aux(tl, element, [hd |> elem(0)])
  end

  def match([hd | tl], element) do
    match_aux(tl, element, [])
  end

  defp match_aux([], element, keys) do
        keys
  end
    
  defp match_aux([{_,element}  = hd | tl], element, keys) do
    match_aux(tl, element, concatenate(keys, [hd |> elem(0)]))
  end

  defp match_aux([hd | tl], element, keys) do
    match_aux(tl, element, keys)
  end

  def destroy(db_ref) do
      :ok
  end

end